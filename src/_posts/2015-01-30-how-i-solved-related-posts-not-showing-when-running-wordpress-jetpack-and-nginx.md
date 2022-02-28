---
title: 'How I Solved Related Posts not Showing when Running WordPress, JetPack, and Nginx'
featured: false
layout: post
categories: posts
date: 2015-01-31T04:05:27.000Z
last_modified_at: '2022-02-28T08:08:12.092Z'
tagged: wordpress
---

Ever since I started this blog up again at the beginning of January, I wanted to have related posts be visible at the end of each post. I use JetPack and I figured turning Related Posts on would be easy and I would be all set.

Well, not so much.

I turned on Related Posts and discovered nothing was appearing. I knew there wasn't really anything that could be wrong as I don't have any errors in WordPress, PHP-FPM doesn't report errors in any of my logs, and I can use other services like [WordPress.com](http://WordPress.com) Stats and the like.

I did some digging and after my search turned up nothing, I reached out to Automatic support and asked about my JetPack issue. We worked through a few things including making sure [WordPress.com](http://WordPress.com) Stats was working, the JetPack servers could see my site (which they did). We even checked to make sure the plugin was even grabbing data to display in the first place. This can be done by adding ?relatedposts to the end of any single post URL. You'll get a JSON blob in return if it's doing what it's supposed to on the back end. We figured, well, that can't be it either. Turns out, the answer wasn't anywhere where I was expecting it to be.

My problem was with my Nginx server configuration for this site.

Here's where it gets technical. For any path, you'll have a set of URIs for the server to try before it gives up. The code usually looks like this:

```
try_files $uri $uri/ /index.php
```

In most cases, that's right! WordPress will work just fine like this. You won't notice errors and everything will parse fine… except for JetPack's Related Posts plugin.

See, with the above line of code, we're telling Nginx that it's ok to try the URI by itself, with a slash after it, or try index.php by itself, depending on what the URI actually is. Nginx, however, is _very_ detail-oriented and will only do exactly what you tell it to do. In my case, I left out a specific instruction: process index.php with arguments, please. By doing so, we turn the above line of code into this line of code:

```
try_files $uri $uri/ /index.php?q=$uri&$args
```

JetPack calls upon that JSON blob I told you about a bit ago just like that: index.php followed by the URI (not fancy, something like a post ID), and any additional arguments necessary after that. So in the case where my post ID is 105 and it's grabbing the related posts for that, it would be calling

```
index.php?q=105&relatedposts=1
```

Boom.

I hope you find this helpful. If you did (or did not), leave a comment below.

