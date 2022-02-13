---
title: Fighting ffmpeg
featured: false
layout: post
categories: posts
date: 2016-07-03 23:32:00 -07:00
last_modified_at: 2022-02-06 14:00:00 -07:00
---

(Last Updated April 1, 2020)

Before I begin this seriously long-winded article (I wasn't expecting it to be nearly 4000 words), I want to let you know that after roughly six hours of poking, yelling at myself, yelling at my screen, yelling at Google for not having the answers I need, and wishing I had just bought IP cameras, I realized `ffserver` doesn't send `mjpeg` with the right `Content-type` header for browser viewing, thus said browsers don't do the right thing to it.

Typical `mjpeg` streams are under the `Content-type: multipart/x-mixed-replace`, whereas `ffserver` transmits with `video/x-mjpeg`. That's fine for players like VLC, but Browsers instinctively download it, versus display it on the screen. What this means for embedding it into a webpage is the stream will download forever, but will only show the first frame. There is no setting for changing this; it's hardcoded into `libavformat/rawenc.c`. After All the fuss of figuring out alternatives, I opted to change [the value](https://github.com/FFmpeg/FFmpeg/blob/master/libavformat/rawenc.c#L281) and re-compile.

This means, after the several hours of compiling `ffmpeg`, I had to re-compile (again)… but will it help? You'll have to find out.

**NOTE** : I've also added some updates to the end from the day after. With a fresh mind, some fresh ideas came up.

## Introduction

Recently I added a Raspberry Pi 3 to my collection of computing tools (mainly for testing `arm` builds of [remote_syslog2](http://github.com/papertrail/remote_syslog2)). While it serves that purpose day in and out, such a task isn't super intensive. While it's just sitting there, I'd like it to do something Internet-related, and what's better than something involving cats? If you say whiskey, I'll give you points. Life is pretty much whiskey, cats, and tacos, for me, as a single guy in his late 20s living in California.

This is where The Cat Cam came to life. I find it oddly amusing to sit and watch my cats (mostly sleep) either from somewhere else in my home or while I'm getting tacos. I figured why not let others do the same, in _a not-at-all-creepy way?_

Here's a pseudo-journal of my progress through this project, including what I've learned, and why I did things in certain ways.

## Motion: An Option

Doing a cursory Google search for `webcam streaming raspberry pi` turned up but a few relevant search results. I guess most people use IP cameras, these days? Either way, I was directed to [this article](https://pimylifeup.com/raspberry-pi-webcam-server/) on how to [build a Raspberry Pi webcam server in minutes](https://pimylifeup.com/raspberry-pi-webcam-server/). Spoiler alert: it took more than minutes.

The idea is that you download [motion](http://www.lavrsen.dk/foswiki/bin/view/Motion/MotionGuide) and run it, tweaking a few things in the `motion.conf` settings file. The article is largely useful but I found the service didn't work and I had to run it under `sudo` to get it to stream; that makes sense given motion has to open and listen on a couple of ports.

A few pointers, here:

- Turn motion detection off. `motion` was originally designed to capture video and stills when any motion is detected, a la security camera.
- Watch out for your saved snapshots. Unless you turn this off, too, figure out how to make it overwrite the files it's saving, [automatically clear out all images](http://unix.stackexchange.com/a/37952) older than a certain date or have a large SD card installed, you'll run out of space. The rate of consumption is based on the frames-per-second being captured. Each image from my 1280×720 Microsoft LifeCam Cinema webcam were about 60kb each at 75% JPEG quality. I burned through [my 16GB SD card](http://amzn.to/29axaFJ) within a few days at one frame per second.
- You'll need a reverse proxy if you don't want to give out your IP address. I opened a port on my router and set up a reverse proxy using [Nginx](http://nginx.org) so as to mask my home IP. My router isn't a huge fan of being port-sniffed, as I discovered when testing, so hiding it was a must.
- The documentation for `motion` is sparse and seems old. The project is still maintained but if you can't figure something out by looking in the `motion.conf` file, you probably won't figure it out, at all.
- Tweaking settings after install and while it's running was easy using the control port. Set a password here, for sure.
- Motion's `Content-type` header and it does output in `multipart/x-mixed-replace`. Why is that important? You'll find out later.

## Switching to `ffmpeg` + `ffserver`

One of the biggest downsides to the configuration I had was the connections to my `motion` server through my proxy were 1-to-1, meaning there was no relay or retransmission which could save on bandwidth. This would end up saturating my home uplink (capped at 10mbps by my ISP). As much as I'd like to, I can't devote all of it to cats.

In comes [ffmpeg](http://ffmpeg.org) and [ffserver](https://trac.ffmpeg.org/wiki/ffserver). This configuration is similar to `motion` in that, there's a process capturing the feed from my webcam on `/dev/video0` and sending it to a server but the server that's broadcasting isn't also on the Pi. Setting this up is broken into two parts: getting `ffmpeg` on my Pi (and running) and setting up the server and configuring it to accept the feed and rebroadcast.

## Using (compiling) `ffmpeg` on ARM

This is, by far, the longest step in this process. `ffmpeg` doesn't come natively compiled for ARM so you'll find yourself wanting to compile it. If you've ever compiled code on a Raspberry Pi before, you'll know this takes time. The smartest in the group are already finding other things to do for when the _hurry up and wait_ step is next.

Since there wasn't any specific article that I could find which accurately depicted how to get `ffmpeg` compiled and working on `arm`, I'll walk you through it.

I'm using a Raspberry Pi 3 with Raspbian. I'm running all my commands as a regular user with `sudo` abilities.

**Update (April 1, 2020):** Since this article still seems to be popular in some regard, it's worth noting that a Raspberry Pi 4 is the same price as a 3, and much more powerful. Use that, instead, if you can.

Before we do anything else, we need to make sure we have the latest package info and install `git`. Nothing special about installing it.

```sh
sudo apt-get update
sudo apt-get install git
```

Let's move into the `/usr/src` directory and pull down the latest version of `ffmpeg`. (Note: most of what we do in `/usr/src` has to be done with `sudo` rights as `/usr/src` is owned by `root`.)

```sh
cd /usr/src
sudo git clone https://git.ffmpeg.org/ffmpeg.git
```

I'm skipping sound, but if you need it, grab [`libasound2-dev`](http://packages.ubuntu.com/search?keywords=libasound2-dev).

Now that we have the code pulled down, let's hop into the folder and compile it.

```sh
cd ffmpegsudo 
./configure
sudo make
make install
```

If that fails, for you, you'll need to install `libav-tools`, you can pick them up using the package manager:

```sh
sudo apt-get install libav-tools
```

Once those are installed, give the compile and install another go.

This step took a couple of hours. I don't know how long, exactly, but it was long enough to where I stopped paying close attention and did other tasks.

We'll need to get source from [deb-multimedia.org](http://www.deb-multimedia.org). This'll require a few bonus steps, but shouldn't be too bad. If you've ever added extra repositories, you'll be familiar with this process, if not, no worries. I've broken it down.

Add these lines to `/etc/apt/sources.list`:

```
deb-src http://www.deb-multimedia.org sid main
deb http://www.deb-multimedia.org wheezy main non-free
```

Then update, again:

```sh
sudo apt-get update
```

and install `deb-multimedia-keyring`:

```sh
sudo apt-get install deb-multimedia-keyring
```

It'll be necessary to get packages from this repo installed properly.

Remove the second source we added earlier because we don't need it any longer, and it'll keep things clean:

```
deb http://www.deb-multimedia.org wheezy main non-free
```

then download the source for `ffmpeg-dmo`:

```sh
sudo apt-get source ffmpeg-dmo
```

This will take a few minutes, but once it's done, you'll find you now have a `usr/src/ffmpg-dmo-xxx` folder, where `xxx` is a version number. Hop into that directory

```sh
cd ffmpeg-dmo-xxx
```

and compile and install it:

```sh
sudo ./configure
sudo make
make install
```

This part will take probably just as long as compiling/installing `ffmpeg` from earlier, so feel free to move on to other cool things. Just don't forget we're here. Those cats need to be seen!

## Setting Up ffserver on a Streaming Relay Server

While `ffmpeg` is compiling, we can work on configuring `ffserver`, the other half of this setup. `ffserver` comes with `ffmpeg` so there's no extra installation of anything. I'm running `ffserver` on another server, outside my home network.

`ffserver` doesn't come configured for anything (it doesn't even come with a config file) so we'll need to set one up at `/etc/ffserver.conf`, as that's where it looks. (If you want to put it elsewhere, make sure to start `ffserver` with the `-f` argument followed by the absolute path to your config file)

In that file, make it look something like this:

```
HTTPPort nnnn
HTTPBindAddress 0.0.0.0
MaxClients 250
MaxBandwidth 10000
file /tmp/stream.ffm
FileMaxSize 10M
Feed stream.ffm
Format mjpeg
VideoSize 640x480
VideoFrameRate 10
VideoBitRate 2000
VideoQMin 1
VideoQMax 10
```

If you're curious as to what all you can tweak, check out this [official sample `ffserver.conf` file](https://www.ffmpeg.org/sample.html) from [ffmpeg.org](https://www.ffmpeg.org/sample.html).

Breaking down the config file, here's what I set and why:

`HTTPPort nnnn` – This will be the port ffserver is listening and serving on. Make sure it's not in use by anything else and traffic can flow freely in and out of it.

`HTTPBindAddress 0.0.0.0` – only useful if you have more than one IP and want to limit it listening on that IP, only. Using `0.0.0.0` lets it listen on all IPs the system knows about.

`MaxClients` – This is the number of unique connections. `ffserver` isn't slow by any means so crank this up and rely on the next setting as your throttle control.

`MaxBandwidth` – In `kbps`, set this to where you feel comfortable.

`ACL allow n.n.n.n` – set this if you want to only allow certain IPs to send their bits as the feed `ffserver` will process. In this case, when primetime is upon us, I'll set this to my home IP address as my Raspberry Pi is behind a NAT.

`Feed [filename]` – This is **super** important. Make sure this _ **exactly** _ matches what's set inside the opening “ tag _and_ not the `file`.

`Format [type]` – This can be any one of the following types:

```
mpeg : MPEG-1 multiplexed video and audio
mpeg1video : MPEG-1 video only
mpeg2video : MPEG-2 video only
mp2 : MPEG-2 audio (use AudioCodec to select layer 2 and 3 codec)
ogg : Ogg format (Vorbis audio codec)
rm : RealNetworks-compatible stream. Multiplexed audio and video.
ra : RealNetworks-compatible stream. Audio only.
mpjpeg : Multipart JPEG (works with Netscape without any plugin)
jpeg : Generate a single JPEG image.
asf : ASF compatible streaming (Windows Media Player format).
swf : Macromedia Flash compatible stream
avi : AVI format (MPEG-4 video, MPEG audio sound)
```

There are two I would stick with: `mjpeg` and `mpeg`. The latter is supported by just about every browser these days and `mpeg` is a straight up video file. Between the former is easier to embed into a website as it's just one line:

```
http://example.com:1234/stream.mjpeg
```

Your browser will likely know what to do with that. Using `mpeg` will require a video player. I'd stay away from Flash-based players, these days (unless you have `swf` as a “, which I'll cover in a minute) because Flash is garbage, ugly, and has no real purpose in today's web world.

**NOTE:** See note number 3 about using mpeg and taking care of your audo stream and note 4 about using non-audio `mpegNvideo`.

Whatever format you choose, make sure the file extension matches in the opening “ tag.

`VideoSize AxB` – This is the final frame size, in pixels. Set this to whatever you feel like, keeping within the same ratio of your source. If you have a 16×9 webcam like myself, do some quick math to get a number that's useful, rounded to the nearest whole number:

```
width * .5625 = height
```

You can also use abbreviations for standard sizes:

```
sqcif, qcif, cif, 4cif, qqvga, qvga, vga, svga, xga, uxga, qxga, sxga, qsxga, hsxga, wvga, wxga, wsxga, wuxga, woxga, wqsxga, wquxga, whsxga, whuxga, cga, ega, hd480, hd720, hd1080
```

Not sure what they mean? Checkout [this Wikipedia article](https://en.wikipedia.org/wiki/Graphics_display_resolution) and search for the abbreviation within.

- `VideoFrameRate 10` – frames per second.
- `VideoBitRate 2000` – The video bitrate in `kbps`. Whatever you set here, divide that into your `MaxBandwidth` from earlier and that'll effectively be the max number of people that can watch your stream.
- `VideoQMin` and `VideoQMax` – The higher the number, the better the overall quality. If you set a range between `Min` and `Max`, the quality will adjust as needed for best picture. The range is `1` for the highest possible quality and `31` for the lowest.

**NOTE:** See the section below titled _Tweaks to the Feed_ for how important it is to make sure these settings are right.

### A Note about Flash & Fallbacks

If you want to have a fallback for non-HTML5 video player support, set up a second “ and configure it for `.swf`. This might not be necessary as good Flash-based players will play regular video files. It's worth thinking about.

If you're looking for Windows Media Player and other streaming app support on older systems, think about `.asf` and `.rm`. They're old, but `ffmpeg` and `ffserver` have been around a _long time_.

## Starting `ffmpeg` and `ffserver`

Now it's time to get this s–t started.

We've spent all this set up time, and now we're ready. You'll want to launch `ffserver` first. If you put your config file in the default location and gave it the default name (`/etc/ffserver.conf`), all you need to do is run:

```sh
ffserver
```

And boom. If something's not right about your config, you'll know pretty quickly. Yellow text can be ignored as it's informational. It's up to you if you want to do anything about it.

The output will look something like this if you did it right:

```sh
root@ubuntu:~# ffserver
ffserver version N-80901-gfebc862 Copyright (c) 2000-2016 the FFmpeg developersbuilt with gcc 4.8 (Ubuntu 4.8.4-2ubuntu1~14.04.3)
configuration: --extra-libs=-ldl --prefix=/opt/ffmpeg --mandir=/usr/share/man --enable-avresample --disable-debug --enable-nonfree --enable-gpl --enable-version3 --enable-libopencore-amrnb --enable-libopencore-amrwb --disable-decoder=amrnb --disable-decoder=amrwb --enable-libpulse --enable-libfreetype --enable-gnutls --enable-libx264 --enable-libx265 --enable-libfdk-aac --enable-libvorbis --enable-libmp3lame --enable-libopus --enable-libvpx --enable-libspeex --enable-libass --enable-avisynth --enable-libsoxr --enable-libxvid --enable-libvidstab
libavutil 55. 28.100 / 55. 28.100
libavcodec 57. 48.101 / 57. 48.101
libavformat 57. 41.100 / 57. 41.100
libavdevice 57. 0.102 / 57. 0.102
libavfilter 6. 47.100 / 6. 47.100
libavresample 3. 0. 0 / 3. 0. 0
libswscale 4. 1.100 / 4. 1.100
libswresample 2. 1.100 / 2. 1.100
libpostproc 54. 0.100 / 54. 0.100
/etc/ffserver.conf:5: No
Daemon option has no effect. You should remove it.
/etc/ffserver.conf:20: Setting default value for video bit rate tolerance = 250000. Use NoDefaults to disable it.
/etc/ffserver.conf:20: Setting default value for video rate control equation = tex^qComp. Use NoDefaults to disable it.
/etc/ffserver.conf:20: Setting default value for video max rate = 2000000. Use NoDefaults to disable it.
/etc/ffserver.conf:20: Setting default value for video buffer size = 2000000. Use NoDefaults to disable it.
```

So cool!

Launching `ffmpeg` is almost as simple. We're going to pass the raw webcam feed so all we need to do is:

```sh
ffmpeg -i /dev/video0 https://example.com:1234/stream.ffm
```

This'll tell `ffmpeg` to that what's coming in from `/dev/video0` and pass it to the feed ingestion point on `ffserver`. If `/dev/video0` isn't available, check for another `video` device. If you have more than one, they'll be numbered in the order they were plugged in, in most cases. You can also ask `ffmpeg` to tell you what devices are plugged in by running:

```sh
ffmpeg -devices
```

The output from `ffmpeg` will look something like this if you did it right:

```sh
pi@rpi3-01:/usr/src/ffmpeg-dmo-3.1.1 $ ffmpeg -i /dev/video0 https://example.com:1234/stream.ffm
ffmpeg version N-80908-g293484f Copyright (c) 2000-2016 the FFmpeg developers
built with gcc 4.9.2 (Raspbian 4.9.2-10)
configuration:libavutil 55. 28.100 / 55. 28.100
libavcodec 57. 48.101 / 57. 48.101
libavformat 57. 41.100 / 57. 41.100
libavdevice 57. 0.102 / 57. 0.102
libavfilter 6. 47.100 / 6. 47.100
libswscale 4. 1.100 / 4. 1.100
libswresample 2. 1.100 / 2. 1.100
Input #0, video4linux2,v4l2, from '/dev/video0':
Duration: N/A, start: 278280.554691, bitrate: 147456 kb/s
Stream #0:0: Video: rawvideo (YUY2 / 0x32595559), yuyv422, 640x480, 147456 kb/s, 30 fps, 30 tbr, 1000k tbn, 1000k tbc
[swscaler @ 0x21bc770] deprecated pixel format used, make sure you did set range correctly
[ffm @ 0x21a7e70] Using AVStream.codec to pass codec parameters to muxers is deprecated, use AVStream.codecpar instead.
Output #0, ffm, to 'https://example.com:1234/stream.ffm':
Metadata:
creation_time : nowencoder : Lavf57.41.100
Stream #0:0: Video: mjpeg, yuvj422p(pc), 640x480, q=1-10, 1000 kb/s, 30 fps, 1000k tbn, 15 tbc
Metadata:
encoder : Lavc57.48.101 mjpeg
Side data:
cpb: bitrate max/min/avg: 2000000/0/1000000 buffer size: 2000000 vbv_delay: -1
Stream mapping:Stream #0:0 -> #0:0 (rawvideo (native) -> mjpeg (native))
Press [q] to stop, [?] for help
frame= 1227 fps= 15 q=24.8 size= 17500kB time=00:01:21.73 bitrate=1754.0kbits/s dup=0 drop=1207 speed= 1x
```

When I first wrote this, I was concerned about `drop=` being anything more than zero, but as it turns out, dropped frames are any that aren't converted and transmitted. If you're transmitting at 1fps, you'll have 29 dropped frames.

If `ffserver` isn't running or isn't listening on the port, you'll get this message:

```
[tcp @ 0x18e7410] Connection to tcp://example.com:1234 failed: Connection refused
https://example.com:1234/stream.ffm: Connection refused
```

You'll get a similar message, but about a `broken pipe` if `ffserver`_was_ running and `ffmpeg`_was_ sending to it, but it subsequently disappeared, was killed, or the connection was otherwise terminated in a ungraceful fashion.

## Tweaks to the Feed

Sending the raw feed could be a bit bandwidth-intensive if you're on something like a DSL connection. My 1280×720 raw feed transmits at about `220KB/second`. That's about 17% of my uplink (10mbps). Depending on what you set for quality, size, and bitrate in the “ portion of your `ffserver` config will reflect the rate at which `ffmpeg` transmits.

### That Damn Buffer

The buffer might be large, so there could be a significant time shift. In my testing, 720×405 at 30fps yielded close to one minute behind live. This might not be a huge deal for you, but it was, for me. I suspect this was because of my Raspberry Pi's inability to encode and transmit quick enough.

### MPEG

- If you use `mpeg`, you'll want to either make sure you have a valid audio stream set up, or you've disabled it in your “ config using the `NoAudio` setting.
- I had a hard time getting `Format mpeg` to work. `ffmpeg` couldn't figure out what to do with the stream. I did some digging and it turns out `mpegvideo` isn't a legit option, but `mpeg1video` and `mpeg2video` are.

### Bandwidth

Bandwidth was a huge issue for me in the early days (read: a few days ago) so this was something I wanted to definitely pay attention to, now. I tested a few different combinations of sizes and frames/second. A few examples I saw in terms of bandwidth needed:



| Dimensions | Frames/second | Quality | Bitrate Observed | `buffer underflow` |
| --- | --- | --- | --- | --- |
| 1280×720 | 1 | min: 1/max: 20 | ~520kbps | no |
| 1280×720 | 15 | min: 1/max: 20 | NaN | yes |
| 720×405 | 30 | min: 1/max: 20 | ~2100kbps | no |



In the beginning, there'll be a spool up as `ffmpeg` tries to get the feed to `ffserver` and get it caught up to live.

## Embedding the Stream

This is where we run into trouble. If you read my Pre-Introduction, you'll know I had to recompile `ffmpeg`/`ffserver` to change the `Content-type` header to `multipart/x-mixed-replace`.

## Real-Time Streaming Protocol

I tried this, too. I won't mention all the specifics but I could never get this to work. I'm not sure what I was doing wrong but `ffserver` wasn't ever able to connect to it's own stream to push it out via RTSP. I suppose you can't win them all.

## Re-compile `ffmpeg` for the Custom `Content-type`

I thought all I'd need to do was re-compile `ffmpeg` on my Pi and I'd be set. I was partially on-target, there. I definitely needed to recompile to change the header, but on the relay server (where I'm running `ffserver`, instead. Instead of installing via `apt-get`, I had to follow the same instructions as I outlined for the Pi.

For my system, I had to install a few extra packages:

```sh
apt-get install build-essential gcc yasm pkg-config
```

Replacing the `Content-type` in `libavformat/rawenc.c` wasn't enough, though as the server still responded with `video/x-mjpeg`. At this point, I'm not entirely sure what to do. I'm thinking about finding another route.

## At the End of the Day

Ugh. This turned out to be more complicated than I originally anticipated. In my mind, it seemed easy to transmit the data from the webcam to a relay server.

`Content-type`, `Content-type`, `Content-type`! I'm going to have dreams about HTTP headers.

## Alternatives

After originally posting this, I started searching for new options. I found [`stream-m`](https://github.com/vbence/stream-m) and might give that a shot.

## Feedback

If you see anything I might have missed, let me know in the comments, below.

## Update: The Day After

After thinking about this some more (#showerthoughts), I remembered we had also installed `ffmpeg-dmo`, which likely was still configured improperly. After updating and re-compiling it, I was able to get the new header, but the browser didn't display the video as a video, but rather binary garbage. VLC was still able to play it.

This led me to look into the `boundary=` attribute for the `Content-type` header. After flipping this on using `-strict-mime-broundary true` on the sending side, it didn't help. I suspect having the `Content-type` be `multipart/x-mixed-replace` isn't actually helping. It seems odd that's the case, though, as Motion returns as that content-type. I'll have to look into it, more.

I swapped the mime-type back to `video/x-motion-jpeg` and re-compiled on the Pi. While this was going on, I looked into other options. I mentioned `stream-m` earlier, and originally liked the idea, but in order to make it work I still have to use `ffmpeg` as the sender _and_ compile it, myself. There's no instructions on how to do that and I've never compiled Java before. Today isn't going to be the day that I learn.

With all that being said, I'm scrapping the `ffmpeg` + `ffserver` idea. Be on the lookout for a follow-up post where I give RTMP streaming a shot.

