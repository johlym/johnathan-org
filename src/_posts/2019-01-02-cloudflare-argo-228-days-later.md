---
title: 'Cloudflare Argo: 228 Days Later'
slug: cloudflare-argo-228-days-later
featured: false


layout: post
categories: posts
date: 2019-01-02 12:32:10.000000000 -08:00
---

<!--missing_image-->

It seems like such a random amount of time to review (and it kind of is) but I wanted to start of 2019 right and review a topic I touched on in 2018: [Cloudflare](https://cloudflare.com)'s [smart-routing](https://www.cloudflare.com/products/argo-smart-routing/) product, [Argo](https://www.cloudflare.com/products/argo-smart-routing/).

In [my previous post about Argo](/a-week-of-cloudflare-argo/), I covered the vast improvements to response times just by enabling the service. Response times were practically cut in half. Since then, I've made some more tweaks to my site so it felt fair to review if Argo is still picking up the slack it claims to. If you're unsure of how Argo works, [my previous post](/a-week-of-cloudflare-argo/) has a good explainer.

## Considering Aggressive Caching

One improvement I made was to lean heavy on Cloudflare's Page Rules functionality. I purchased myself a set of five Rules for an additional +$5.00/month and got to work. I focused on wielding caching for everything that isn't likely to change often if ever. In this case, most static assets will live on Cloudflare's servers and in a visitor's browser for quite a while.

<!--missing_image-->
_When I first implemented this, I didn't consider plugin JS, but in reality, most of what's being caught by that rule is WordPress-related (read: Jetpack), and I haven't experienced issues thus far._

With the majority of `/wp-content` being taken care of with page rules, it was time to re-evaluate the now decreased load and its effect on the benefits Argo provides.

## Argo Post-Aggressive Caching

There's a reason Cloudflare recommends Argo regardless of how you cache. Even with aggressive caching in place, I'm still seeing about 25% response time improvements:

<!--missing_image-->

The average runs between 23-27%, depending on the days I'm checking, but the 23.28% in the image above is pretty close to “most of the time.” What's also worth pointing out is the peaks and valleys largely follow the same percentage improvement across the board, and it's no wonder: 75% of requests end up going through Argo's pipeline.

With the aggressive Page Rules and Argo, I'm comfortable in saying Argo has a permanent home with this site and any future projects I take on. It's a no-brainer and still remains highly cost-effective.

