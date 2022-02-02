---
title: The CDN Contemplation
slug: the-cdn-contemplation
featured: false


layout: post
categories: posts
date: 2016-05-28 17:24:20.000000000 -07:00
---

About four weeks ago, I bolted a CDN to my blog. The goal: what kind of benefit would I, someone who receives a small but steady stream of traffic, get from such a technological underpinning?

This CDN is nothing fancy. Powered by [MaxCDN](http://tracking.maxcdn.com/c/35573/3982/378?u=https%3A%2F%2Fwww.maxcdn.com%2F), It takes my site assets (CSS, JavaScript, and images) and tosses them around the world to their edge servers. In exchange, I can load said assets from `cdn.john.ly` and an origin server shall provide.

### What is a CDN, really?

> A content delivery network or content distribution network (CDN) is a large distributed system of servers deployed in multiple data centers across the Internet. The goal of a CDN is to serve content to end-users with high availability and high performance. CDNs serve a large fraction of the Internet content today, including web objects (text, graphics and scripts), downloadable objects (media files, software, documents), applications (e-commerce, portals), live streaming media, on-demand streaming media, and social networks. (https://en.wikipedia.org/wiki/Content\_delivery\_network)

The short version of that is all the files that need to load fast are put on servers as close to as many people as possible. Example: This site runs on a server in San Franciso, CA. That's great for people like me who live nearby. Also great for those who live within roughly the same country. This isn't so great for a person in South Africa, Ireland, or Russia. The amount of time it takes to load all the fun bits is greatly increased as physical distance also increases.

### Costs

I run this site with little to no overhead. I pay the price of four fancy cofffees from Starbucks every month to Digital Ocean for the virtual server. With [static page generation](https://wordpress.org/plugins/wp-super-cache/) in place, the site already uses little resources, so I don't expect it to increase anytime soon. [MaxCDN](http://tracking.maxcdn.com/c/35573/3982/378?u=http%3A%2F%2Fmaxcdn.com%2Fpricing%2Fentrepreneur%2F) starts at $9/month for [100GB of transfer](http://tracking.maxcdn.com/c/35573/3982/378?u=http%3A%2F%2Fmaxcdn.com%2Fpricing%2Fentrepreneur%2F). For anyone running a blog on a small scale, you won't hit 100GB a month. I promise. There's no free plan but there is a free intro for a month.

Beyond that, if you want to add an SSL certificate, you have two options: SNI (free) or [EdgeSSL](http://tracking.maxcdn.com/c/35573/3982/378?u=https%3A%2F%2Fwww.maxcdn.com%2Ffeatures%2Fssl%2F) ($99/month). For the small blogger, EdgeSSL (which comes with an IP and SSL certificate) is overkill. SNI is a feature of the TLS encryption protocol pretty much the entire secure Web runs with that allows a client (browser) to tell the server which hostname its trying to connect to and the server returns the right SSL certificate. From there, the whole rainmaking SSL handshake dance commences. Naturally, I opted to take the SNI route but in return needed to provide my own SSL certificate.

Why an SSL certificate? If your site is served over an HTTPS connection and you start loading a buch of assets that aren't served over an HTTPS connection, some browsers are going to barf. Best case scenario it's mildly annoying for the visitor and worst case, those assets never load. That fancy font you have is useless.

I [picked up](https://www.namecheap.com/security/ssl-certificates.aspx?aff=67222) a year-long [SSL certificate](https://www.namecheap.com/security/ssl-certificates.aspx?aff=67222) for ~$9 and change from [Namecheap](https://www.namecheap.com/?aff=67222). I used to use them for my domains (and have since moved to Hover) but their SSL offerings are great for the little guy. Now we're up to $9 out of pocket to start and $9/month.

Beyond those two costs, there wasn't much else I needed to pay for. I spent a few hours poking at MaxCDN's interface trying to get them to accept my SSL certificate, only to find out I was giving them part of the certificate for `cdn.john.ly` and part of the certificate for `john.ly`. A copy and paste mistake that their UI did a terrible job of alerting me to. All I got in return was a vauge _Internal Error_ message and support wasn't much help in decoding it. By the time they got back to me, I had figured it out.

### Implementation

This is something that's likely news to zero people. This site currently is run on [WordPress](https://wordpress.org). The quickest way to implement a CDN on WordPress is via a plugin like [WP Super Cache](https://wordpress.org/plugins/wp-super-cache/). It takes two minutes and boom, you're CDNing all over the place. When setting it up for the first time, there's no cached resources on the CDN servers, and that's fine. The most common type of CDN is referred to as `pull`. On first request (say to `https://cdn.john.ly/stylesheet.css` if that actually existed), the CDN figures out it doesn't have that so it redirects to `https://johnathan.org/stylesheet.css` for the visitor _and_ fetches a copy onto which it will hold until further notice. Usually this notice is once every X hours or days. After that period of time, the files it has “expire” and on the next request, the process restarts.

The downside to this is updating such resources locally while making changes to the site. If I were to, say, update the size of my post titles locally, and did nothing else, it wouldn't be obvious until probably tomorrow. This is where force purging the CDN's cache comes in. All CDN providers have this option and it's super easy. Within a couple minutes everything is fresh, again.

### So was it worth it?

That's hard to say. Given I don't serve a ton of images, I didn't use much in the way of CDN resources (a bit over a GB). Even [at $9 per month](http://tracking.maxcdn.com/c/35573/3982/378?u=http%3A%2F%2Fmaxcdn.com%2Fpricing%2Fentrepreneur%2F), I don't think the benefit was great enough. That said, the service itself was pretty good. It was easy to set up (sans SSL, and if I was paying closer attention, that wouldn't have been an issue, either). At this point, My traffic would need to at least quadruple before I think about re-introducing a CDN into the mix. Either that or a free tier that I can upgrade from easily (or pay as I go per GB like [Amazon Cloudfront](https://aws.amazon.com/cloudfront/)).

### Should I go for it?

If you have a good amount of traffic and or are looking to decrease bandwidth usage on your primary server(s), it's worth looking into, for sure, and [MaxCDN](http://tracking.maxcdn.com/c/35573/3982/378?u=http%3A%2F%2Fmaxcdn.com%2Fpricing%2Fentrepreneur%2F) is my favorite. If you're at that point where you're serving mid-double digit GBs per month, it's hard to argue with $9/month and you'll probably see an improvement. If you're serving a lot of photos or videos, then I would _definitely_ look into it. People have zero patience, these days.

_Disclaimer: some of the links in this post are of the affiliate nature._

