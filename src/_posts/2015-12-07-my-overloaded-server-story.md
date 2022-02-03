---
title: My Overloaded Server Story
slug: my-overloaded-server-story
featured: false


layout: post
categories: posts
date: 2015-12-07 09:47:35.000000000 -08:00
---

So as you probably know by now, I converted my blog to [Jekyll](http://jekyllrb.org/), yesterday, and it's been a huge success, in my opinion. I'm motivated more than ever to start blogging more because I have the added tinker factor and using Git and GitHub to keep everything organized rocks.

But that isn't what this story is about. Tonight's story is about a server. A lowly VPS floating somewhere in the SFO [DigitalOcean](http://digitalocean.com/)…. ocean. I've had this server running for many months–probably over a year now and I just don't know it–and it's hosted just about anything and everything I've tinkered with including many a failed idea.

I use this server a lot and for the most part it always responds well and isn't sluggish. It's hosted my former [WordPress blog](https://johnathan.org/) since January and hasn't made but a peep about it so I've spent quite a bit of time thinking nothing's amiss. I felt, though, that Jekyll shouldn't be taking as long as it was to build my site but I couldn't convince myself the server was overloaded.

As it Turns OutTM, I was wrong.

My baby of a server has, for the last five or so months, been filling [Newrelic](http://newrelic.com/) graphs with stuff like this:

**CPU**

{% cloudinary_img "Alt text goes here", "loaded_server_before_cpu", "large" %}

**Memory**

{% cloudinary_img "Alt text goes here", "loaded_server_before_mem", "large" %}

**Disk**

{% cloudinary_img "Alt text goes here", "loaded_server_before_disk", "large" %}

**Load**

{% cloudinary_img "Alt text goes here", "loaded_server_before_load", "large" %}

So I'm just going to go ahead and say that's not good. The only graph above that's even remote decent is the Disk graph, but it's washed over by the CPU \> 80% indication so it's also pretty much hosed.

At this point I'm honestly surprised. I'm a terrible pseudo-sysadmin and I should be fired but there's no one to fire me and I'm the boss so whatever. If I can fix all this, I'm giving myself a raise.

I started digging. I wanted to see what's running and who's sucking up all the juices. I fired up `top` and waited a few seconds. A few things popped up: a couple instances of `node` and an instance of `ruby`.

Hmm. That doesn't make any sense… I'm not running any node apps and jekyll is the only ruby thing I use right now… oh wait.

See, I tinkered with NodeJS apps late last spring. [Ghost](http://ghost.org/) was a blogging tool I was considering for a while. I also tinkered with [Discourse](http://discourse.org/) to see what it was all about. Turns OutTM, neither are suited for my needs.

I don't really know what happened but I can only assume I forgot about them and they've been running all this time. I had a total of five Node instances running and Docker was running Discourse so between the two of them, I was on `swap` 24/7. So dirty.

This story isn't super climactic in any way and the fix was easy: kill all the things. I also found this to be a good time to remove Node and Docker since I need neither.

I still couldn't figure out why my disk usage was so high, though. Leave it to me to forget about a 4GB `.iso` I left in a folder and leave it to Discourse to fail at sending 5GB of emails through postfix over the last five months and clog up my `/var/mail` folder. Needless to say, after the almost-winter cleaning, I gained quite a bit of ground:

**CPU**

{% cloudinary_img "Alt text goes here", "loaded_server_after_cpu", "large" %}

**Memory**

{% cloudinary_img "Alt text goes here", "loaded_server_after_mem", "large" %}

**Disk**

{% cloudinary_img "Alt text goes here", "loaded_server_after_disk", "large" %}

**Load**

{% cloudinary_img "Alt text goes here", "loaded_server_after_load", "large" %}

Sorry this story wasn't more interesting. If you're curious, my Jekyll build time was cut in half.

That's about it. Orphaned tools and processes makes my server a dull VPS.

