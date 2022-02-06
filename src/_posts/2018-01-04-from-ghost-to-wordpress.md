---
title: From Ghost to WordPress
slug: from-ghost-to-wordpress
featured: false
layout: post
categories: posts
date: 2018-01-04 10:31:38 -08:00
last_modified_at: 2022-02-06 14:00:00 -07:00
---

I did what I never thought I'd end up doing. Over the last month, I'd been contemplating moving away from Ghost as a blogging platform and back to WordPress. [Back in June](/strange-things-around-these-parts/) I moved away from WordPress. My original complaints were related to complexity, bloat, and performance. I felt WordPress was becoming too slow and complicated for a simple blog like this one. I watched as Ghost became a more mature and baked tool so I dove in. Wiring up a design for it was a trivial matter, something I greatly appreciate still. The simplicity in design wasn't enough to keep me, however, along with a few other reasons.

Before I took the plunge and moved back to WordPress, I took some time to figure out and decide if I'm doing this for the right reasons or if I'm just bored and wanted to see something new. After a couple weeks of pondering, I came up with this list for moving away from Ghost.

**No intention on supporting MicroPub**. This made it hard to publish anywhere but johnathan.org/ghost. The development team made it pretty clear that the only way one was going to publish anything externally was via their API which, as of this writing, is still not documented very well, not supported, and is very much in `beta` status. This by itself isn't a deal breaker as I'm still contemplating if I want to use a tool that plugs into WordPress at all or if I'm going to stay within a single-purpose markdown app and copy-paste when I'm finished.

**Extensibility is non-existent**. Plugins. Not a thing. There's a distant promise of “apps” support coming soon, which I assume would be plugin-esque, but they're likely going to be limited in nature and won't augment the capability of Ghost so much as integrate with other things. This was made painfully apparent when I looked into the feasibility of redundancy and load balancing as well as serving static assets from elsewhere. Re-writing the asset path is a shame-shame move and Ghost doesn't play nice with itself–it's a bit of a loner–so both ideas were shot down.

**Low ceiling for theme capabilities**. I think what tipped the scale in this category was when I tried to figure out how to display a list of archive months on the left-hand side of every page and discovered it was basically impossible without hitting the API for _all_ the post data then squashing it down a few times to get a list of months. At almost 300 posts, having to do that on the client side was nonsense and a non-starter. Ghost theme design is pretty simple and for those who've worked with a templating engine before, something usable can be had in an hour, tops. I just wish the templating engine was actually capable.

**Poor content organization**. Trying view a large list of posts is hard when you can only fit a handful on screen at a time. When I made this migration, I had 291. Yes, search worked, and it worked pretty well, but sometimes I didn't remember what I was looking for or wanted to bulk edit tags. Good luck. The icing on the cake was that there's no separation between posts and pages, something that really hits home that the makers of Ghost don't want you to use it as a regular CMS. They seem to despise that idea and have attempted to make a product that's as far away from that as possible. They definitely succeeded in making a blogging-first application, but some of the design principles that comes with such a classification may have been taken a bit too far.

**Poor performance**. The public-facing site was fast. Very fast. That's one thing Ghost does super well out of the box. The admin page isn't so keen on trying to manage 291 blog posts, though. I found that after a couple paragraphs of text, the editor would slow to a crawl quite reliably. JavaScript. It'll run the world one day and the world will be slower for it.

### But a side note about WordPress

**Update** : I used to have some information here about Jetpack committing various sync activities and holding up performance of the admin side of the app. I lost the screenshots during a server migration and so this section didn't make a lot of sense without them so I pulled it. Sorry about that.

WordPress is much faster than I remember it being, and adding caching and keeping calls to a minimum, everything renders pretty dang quickly—about as fast as with Ghost.

This is exactly the change I needed to start 2018.

