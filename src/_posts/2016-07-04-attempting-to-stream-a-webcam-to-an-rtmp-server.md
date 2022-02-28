---
title: Attempting to Stream a Webcam to an RTMP Server
featured: false
layout: post

date: 2016-07-04 22:16:00 -07:00
last_modified_at: 2022-02-28T23:10:42.527Z
tagged: programming
---

This a follow up from [this article I wrote](/fighting-ffmpeg/) talking about trying to get `ffmpeg` + `ffserver` running the Cat Cam. I abandoned that project and went in search for a new solution. What I came up with was `ffmpeg` + `nginx`. Here's how that worked out.

After a night of streaming failure, I decided I'd give a shot at using `ffmpeg` to stream to an RTMP server via `nginx`. RTMP servers are generally pretty basic in that they just relay what they receive to whomever connects. This seems like a pretty straightforward process, from what I can tell. The hardest part would be to get the `nginx` source bits and compile it with [the `nginx-rtmp-module`](https://github.com/arut/nginx-rtmp-module). Here's how we'll do that.

## Quick Side Note

Before we begin, I found out during this process I never compiled `ffmpeg` with `H.264` support. If you didn't, either, let's sidetrack for a moment. Run this to find out:

```sh
ffmpeg -encoders | grep 264
```

If `H.264` isn't on the list, then let's re-compile :

```sh
./configure --enable-gpl --enable-libx264
make
make install
ldconfig
```

**NOTE** : If you get an error saying it can't find the library:

```
ERROR: libx264 not found
```

then you'll need to run (with periods):

```sh
apt-get install yasm libvpx. libx264.
```

Once that's done, verify `ffmpeg` has `H.264` support and let's move on.

```sh
ffmpeg -encoders | grep 264
```

## Nginx

### Compile & Install

Since we're getting the generic `nginx` from source, we'll need to make sure some libraries are installed. You can always compile `nginx` without them, but that's more work, in my opinion, and could lead to problems, later. You might not need all of these, but the Linux system I'm working on was missing most of this; never hurts to share.

```sh
apt-get update
apt-get install libpcre3 libpcre3-dev libssl-dev
```

We'll need the `nginx` source. Pick it up [here](http://nginx.org/download/). I used `nginx-1.10.1`. I'm a fan of newer versions when possible. and it's been out for a month, now. I suspect it's stable.

```sh
cd /usr/src
wget http://nginx.org/download/nginx-1.10.1.tar.gz
tar -xvf nginx-1.10.1.tar.gz
```

You'll also need to get the rtmp module, for nginx, as well.

```sh
git clone https://github.com/arut/nginx-rtmp-module
```

Once you have both of those, compile!

```sh
cd nginx-1.10.1
./configure --add-module=/usr/src/nginx-rtmp-module
make
make install
```

Nginx will be installed to `/usr/local/nginx`.

if you plan on running `nginx` from the command line and not `/usr/local/nginx` all the time, you'll want to create a symbolic link or add the directory to your path. I opted for the link:

```sh
ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
```

### Configure

Now that compiling is out of the way, let's modify the `nginx.conf` to add our `rtmp` bits. Your config file, located at `/usr/local/nginx/conf/nginx.conf` should look something like this:

```
rtmp {
  server {
    listen 8081;
    chunk_size 4000;
    
    # HLSapplication 
    hls {
      live on;
      hls on;
      hls_path /tmp/rtmp_hls;
    }
  }
}
  
# HTTP can be used for accessing RTMP stats

http {
  server {listen 80;
  
  # This URL provides RTMP statistics in XML
  location /stat {
    rtmp_stat all;
    
    # Use this stylesheet to view XML as web page
    # in browser
    # rtmp_stat_stylesheet stat.xsl;
  }
  
  # location /stat.xsl {
    # XML stylesheet to view RTMP stats.
    # Copy stat.xsl wherever you want
    # and put the full directory path here
    # root /path/to/stat.xsl/;
  # }
    
    location /hls {
      # Serve HLS fragments
      types {
        application/vnd.apple.mpegurl m3u8;
        video/mp2t ts;
      }
      
      root /tmp;
      add_header Cache-Control no-cache;
    }
  }
}

events { 
  worker_connections 1024; 
}
```

Whatever you set your `hls_path`, make sure that directory exists. If you have an XML stylesheet (`xsl`), set that in the `location /stat.xsl` block, too, and uncomment `rtmp_stat_stylesheet`.

Kick off `nginx` and make sure it's listening on your port:

```sh
netstat -an | grep 8081
```

If it's running, you'll see this:

```
tcp 0 0 0.0.0.0:8081 0.0.0.0:* LISTEN
```

Now that we have that set up, let's get a player. I'm opting for JW Player. you can pay money for it, if you want, but you're really just paying for their service. the Player files are 100% free. [This](https://www.jwplayer.com/pricing/) is their official site, but you can also snag it [from GitHub](https://github.com/jwplayer/jwplayer).

How you want to implement it is up to you.

## Setting Up `ffmpeg`

Let's give this another go. The command you can use here is a little more complicated as we'll need to stream a legitimate video, but here's the idea:

```sh
ffmpeg -i /dev/video0 -framerate 1 -video_size 720x404 -vcodec libx264 -maxrate 768k -bufsize 8080k -vf "format=yuv420p" -g 60 -f flv rtmp://example.com:8081/hls/live
```

Breaking this down, we have the following:

`-i /dev/video0` – The input stream.

`-framereate 1` – The number of frames per second in the feed.

`-video_size 720x404` – The size of the final video.

`-vcodec libx264` – the `H.264` codec we're using.

`-maxrate 768k` – The max bitrate `ffmpeg` will use to compress the video. Naturally the higher the bitrate, the more bandwidth you'll need.

`-bufsize 8080k` – The buffer `ffmpeg` will work with. It'll need this if it can't get the video out quick enough.

`-vf "format=yuv420p"` – The colorspace and raw video data format.

`-g 60` – Set the distance between the start and end of the [Group of pictures](https://en.wikipedia.org/wiki/Group_of_pictures).

`-f flv` – The container format we're sending to the server.

`-rtmp://…` – The absolute URL of the RTMP stream.

## We're Streaming!

At first I was super excited that it started working, but a problem arose, pretty quickly: it's streaming way behind real time. After about ten minutes, the speed was near 1x, but still not quite there, and I suspect the buffer was quite full. VLC takes about 30 seconds to start playing the video.

At least it's _sort of_ working, right?

My JW player isn't able to load the stream, so some tweaks will be needed.

## If only…

The RPI3 isn't strong enough to live-encode `H.264`. I'd bet lots of dollars that if I had a stronger piece of hardware to work with, It could do it, and this wouldn't be an issue. I might see what would happen if I used my MacBook as a test.

I really wish I could embed this into my site. JWPlayer isn't going to ever be happy with the stream the way it is. A thought that came to mind is going back to `motion`, using my streaming server to capture the `mjpeg` stream with `ffmpeg`, then relay it to the `rtmp` server in a better format.

Stay tuned for part three when I figure out if that's worth my time.

