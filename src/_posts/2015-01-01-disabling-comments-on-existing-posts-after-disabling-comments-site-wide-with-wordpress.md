---
title: Disabling Comments on Existing Posts After Disabling Comments Site-Wide with
  WordPress
slug: disabling-comments-on-existing-posts-after-disabling-comments-site-wide-with-wordpress
featured: false


layout: post
categories: posts
date: 2015-01-01 11:03:53.000000000 -08:00
---

 **Update:** I can't seem to replicate this issue anymore and thus closed out the bug I submitted below. I ran into an issue this morning after disabling comments site-wide on this particular site that I could no longer enable the Discussion widget to disable comments on existing posts. Since this seems like an issue others would run into, I took the liberty of [creating a bug against WordPress 4.1 addressing the issue](https://core.trac.wordpress.org/ticket/30880). If you're interesting in following, feel free to do so here or via the bug itself.

## Workaround

While clunky, my work around was to re-enable comments site-wide so as to have the Discussion widget return as an option in the Post Editor so I could disable comments for my existing posts. I cannot speak as to wether it was limited to just _published_ posts as I did not test it.

