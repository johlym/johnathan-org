---
title: A Week of Cloudflare Argo
slug: a-week-of-cloudflare-argo
featured: false


layout: post
categories: posts
date: 2018-05-21 17:00:00.000000000 -07:00
---

I recently made a pretty heavy shift over to [Cloudflare](https://cloudflare.com). The majority of assets and HTML on this site load from Cloudflare's servers now, instead of my own. The only time this differs is when I push changes up to its GitHub repo. The last step in the build process after deploying to my server is hitting the API and requesting a complete cache dump. I could be more programmatic about it but updates aren't frequent enough to warrant a more careful approach.

On its own, Cloudflare's caching and CDN is great, but there's another piece that makes it even better. [Argo](https://blog.cloudflare.com/argo/) is Cloudflare's smart routing feature that makes real-time choices about the best path to take from the [Cloudflare POP](https://www.cloudflare.com/network/) (point of presence) to the origin (my server). This can dramatically reduce requests that _do_ have to make their way to my San Francisco-located server.

It's $5 a month plus $.10 per GB. Since most of the content on this site is text and a smattering of images, I'm not concerned with the price and $5 is fun money, basically. I saved that moving from DNSimple to Cloudflare for DNS, too, so there's that.

Looking at some of the stats, now…

<!--missing_image-->

As reported by [Updown.io](https://johnathan.org/goto/updown) (the service that powers [status.johnathan.org](https://status.johnathan.org) and the uptime percentage at the bottom of the page), the majority of my requests come in in no time at all, with the obvious winner being Los Angeles (closest to San Francisco, my [DigitalOcean](https://johnathan.org/goto/digitalocean) location). The outlier is France, though I'm not too concerned with it. It seems to be fluctuating.

( **Update May 24, 2018** : I noticed response times from Updown.io had dropped to sub 100ms averages thanks to France falling in line with the rest of the countries. The only outlier at this point is Sydney's lookup taking 3-9x longer) than the other locations.)

Moving over to [Pingdom](https://pingdom.com)…

<!--missing_image-->

It's pretty obvious when Argo was enabled. I'm not sure what happened with the spike half-way between the 16th and 17th, but a response time being cut in half is amazing, even after doing **zero** work on the server, itself.

Lastly, the Cloudflare stats…

<!--missing_image-->

We see a clear difference in their metrics of response time improvements. Including the entire TLS handshake process, these sub 200ms response times in most cases is wonderful. At scale, Argo would have the potential to be mind-numbingly fast.

I'll continue to use [Argo](https://blog.cloudflare.com/argo/) for the foreseeable future. [Cloudflare](https://cloudflare.com) is free and works great for hobbyists like myself. [Argo](https://blog.cloudflare.com/argo/) is $5 + $0.10/GB and I'd consider that peanuts. If it's of any help, I've sent maybe 50MB through it since I signed up a week ago (remember, mostly text and a few images).

