---
title: Add RTMP Support to Nginx Installed From Apt
featured: false
layout: post

date: 2016-07-08 17:14:00 -07:00
last_modified_at: 2022-02-28T23:10:45.641Z
tagged: programming
---

In the process of trying to figure out the best streaming solution for my cat cam, I had to deviate a bit. I combined my RTMP server for my cat cam and Web server for johnathanlyman.com into one and the latter didn't have the RTMP module installed. This module is required for my attempts to push H.264 video and have Nginx relay it to whomever is watching, cutting down on the bandwidth of my one-to-one reverse proxy setup I have, now.

It's a pretty straightforward process to re-compile Nginx, but there are a couple extra steps involved if you installed Nginx from a package repo. I'll be sure to cover these. What we're doing here is re-compiling a deb package. By going that route, we'll adhere to the same methods in which Nginx was installed in the first place so we don't have two competing installs.

Like my other [RTMP/Nginx-inspired post](/stream-rtmp/), I'm using Ubuntu 16.04 (xenial), so everything will revolve around that.

Before we begin, we'll want to make sure we're updated and ready to go:

```sh
apt-get updateapt-get upgrade
```

Next, install `software-properties-common` if needed then add the `nginx/stable` ppa.

```sh
apt install software-properties-commonadd-apt-repository ppa:nginx/stable
```

Now we'll be able to grab the source files from the repo.

```sh
cd /usr/srcapt-get build-dep nginxapt-get source nginx
```

Whatever directory you run that in is where the source and dependency files will appear. I chose `/usr/src` as that's where we've been working [in these](/fighting-ffmpeg) [previous posts](/stream-rtmp/). Mine looks something like this:

```sh
user@server:/usr/src# ls -altotal 1888
drwxr-xr-x 4 root root 4096 Jul 8 17:20 .
drwxr-xr-x 10 root root 4096 Apr 21 09:56 ..
drwxr-xr-x 10 root root 4096 Jul 8 17:20 nginx-1.10.1
-rw-r--r-- 1 root root 1000448 May 31 19:05 nginx_1.10.1-0+xenial0.debian.tar.gz
-rw-r--r-- 1 root root 2765 May 31 19:05 nginx_1.10.1-0+xenial0.dsc
-rw-r--r-- 1 root root 909077 May 31 19:05 nginx_1.10.1.orig.tar.gz
```

Let's move into the source folder and download the RTMP module:

```sh
cd nginx-1.10.1/debian/modules/git clone https://github.com/arut/nginx-rtmp-module
```

Back up one directory and open `rules` in a text editor. I'm using `nano`. Add the module to the end of the `--add-module` list under the `common_configure_flags` or `full_configure_flags` like so:

```
[common|full]_configure_flags := $(common_configure_flags) 		

[...]

--add-module=$(MODULESDIR)/ngx_http_substitutions_filter_module                         
# NEW MODULE BELOW @                        
--add-module=$(MODULESDIR)/nginx-rtmp-module
```

Now that the module is in, let's re-compile!

```sh
cd /usr/src/nginx-1.10.1dpkg-buildpackage -uc -b
```

Depending on how powerful your server is will determine largely how long this takes. I say go get a beverage and come back in a few minutes.

Once it's done, you'll get your set of `.deb` packages:

```sh
cd /usr/srcuser@server:/usr/src# ls -al 
total 16088
drwxr-xr-x 4 root root 4096 Jul 8 17:52 .
drwxr-xr-x 10 root root 4096 Apr 21 09:56 ..
drwxr-xr-x 10 root root 4096 Jul 8 17:20 nginx-1.10.1
-rw-r--r-- 1 root root 23788 Jul 8 17:52 nginx_1.10.1-0+xenial0_all.deb
-rw-r--r-- 1 root root 3756 Jul 8 17:52 nginx_1.10.1-0+xenial0_amd64.changes
-rw-r--r-- 1 root root 1000448 May 31 19:05 nginx_1.10.1-0+xenial0.debian.tar.gz
-rw-r--r-- 1 root root 2765 May 31 19:05 nginx_1.10.1-0+xenial0.dsc
-rw-r--r-- 1 root root 909077 May 31 19:05 nginx_1.10.1.orig.tar.gz
-rw-r--r-- 1 root root 43932 Jul 8 17:52 nginx-common_1.10.1-0+xenial0_all.deb
-rw-r--r-- 1 root root 35342 Jul 8 17:52 nginx-doc_1.10.1-0+xenial0_all.deb
-rw-r--r-- 1 root root 746780 Jul 8 17:52 nginx-extras_1.10.1-0+xenial0_amd64.deb
-rw-r--r-- 1 root root 6627998 Jul 8 17:52 nginx-extras-dbg_1.10.1-0+xenial0_amd64.deb
-rw-r--r-- 1 root root 471502 Jul 8 17:52 nginx-full_1.10.1-0+xenial0_amd64.deb
-rw-r--r-- 1 root root 3806376 Jul 8 17:52 nginx-full-dbg_1.10.1-0+xenial0_amd64.deb
-rw-r--r-- 1 root root 333962 Jul 8 17:52 nginx-light_1.10.1-0+xenial0_amd64.deb
-rw-r--r-- 1 root root 2428032 Jul 8 17:52 nginx-light-dbg_1.10.1-0+xenial0_amd64.deb
```

We'll need to remove Nginx. As long as we don't `purge`, the config files will stay in place. It never hurts to get a backup, anyway, though.

```sh
apt-get remove nginx [nginx-core]
```

Now let's install our newly compiled version of Nginx:

```sh
dpkg --install /usr/src/nginx-[common|full]_1.10.1-0+xenial0.amd64.deb
```

If it didn't blow up, we're in decent shape. To be in even better shape, make sure your moduler was installed by running `nginx -V`. You should see something like the same line you added to the `rules` file from earlier (probably at the end):

```
[...] 

--add-module=/usr/src/nginx-1.10.1/debian/modules/nginx-rtmp-module
```

Since we tinkered with Nginx, mark it for version hold so `apt-get upgrade` doesn't wipe out our changes:

```sh
apt-mark hold nginx-full
```

That's all you need to do. Happy sysadmin-ing!

