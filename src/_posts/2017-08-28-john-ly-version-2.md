---
title: John.ly Version 2
slug: john-ly-version-2
featured: false
og_title: John.ly Version 2 – Johnathan.org
og_description: Last week I hacked together a new version of my blog (this site) in
  hopes that I could actually create what I had envisioned in my head all along. So
  far, I’m q
meta_title: John.ly Version 2 – Johnathan.org
meta_description: A hand-crafted technology product by Johnathan Lyman
layout: post
categories: posts
date: 2017-08-28 03:43:52.000000000 -07:00
---

Last week I hacked together a new version of my blog (this site) in hopes that I could actually create what I had envisioned in my head all along. So far, I’m quite pleased with how it turned out. I look forward to hacking on it some more, but this is a great start.

There were a few things I had to have in this version.

**Easier to read type**. I spent a few hours poking around the various font circles on the Interwebs and came across [ITC Charter](https://www.myfonts.com/fonts/itc/charter/). I really like the way it renders on a page and from what I can tell, Medium.com also uses Charter. I guess I’m in good company?

**Wider single-column layout**. It didn’t have to be large, but something larger than before in order to accommodate flexibly-sized images. The CSS allows for image URLs to contain `#med` and `#big` and the content will eventually accommodate that.

**A touch of color**. The minimal design in the previous version was nice, but it felt bland. The light-blue links weren’t cutting it.

**Navigation that’s always available**. Scrolling to the top is no longer a thing.

**Be small-ish**. I wanted to keep the theme zip under a meg. The uncompressed them folder is around 760KB on my machine. The largest assets are the font files for each format (woff, woff2, eot, otf) at around 200-ish KB. The homepage, when loaded, sans tracking scripts is roughly 250KB with jQuery. A blog post will vary depending on images.

I’ve also shared the code on [GitHub for those interested. I can’t say the repo will always be updated but I’ll do the best I can to remember.

