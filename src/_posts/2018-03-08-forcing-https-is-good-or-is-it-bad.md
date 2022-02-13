---
title: Forcing HTTPS is Good… or is it Bad?
featured: false
layout: post
categories: posts
date: 2018-03-08 13:03:16 -08:00
last_modified_at: 2022-02-06 14:00:00 -07:00
---

There's a bit of a debate in various corners of the Internet about how Google's adding of `Not Secure` to HTTP-only sites as an indicator in the address bar is somehow bad for the Internet.

This tweet sums up both sides nicely:

<blockquote class="twitter-tweet">
The sites that have stood the test of time are our most valuable — but they are the least likely to be updated. No platform change is worth losing 20+ years of accumulated value

— Matt Webb (@genmon) [March 8, 2018](https://twitter.com/genmon/status/971686493004713984?ref_src=twsrc%5Etfw)
</blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

I have mixed feelings. I get where folks are coming from when they say that Google shouldn't be doing this carte blanche, but it also seems like a petty hill to die on. Google is a s–t company but HTTPS is easy, free, and at least does some stuff to ensure the content you're accessing is the content that was served. The barrier for entry into an HTTPS-enabled Web site is super low and we should be making these migrations independently of what Google is pushing.

Sure, adding that indicator is a scare tactic, and I'd bet it'll be a good one. We should also be cautious that anywhere between your site and your visitor, there's the very real possibility someone could very well take over that connection and replace the site or inject code on a whim. ISPs are for the most part shitty companies all around. Does moving to HTTPS only solve that problem? No, but it does provide piece of mind.

If folks are worried about their sites that have 15 years worth of content and haven't been largely updated since 2004 all of a sudden becoming irrelevant or the “Independent” web being silenced… fine. We need to start somewhere in setting the benchmark for the Internet to be _above_ plaintext HTTP. I don't see other alternatives that don't make things _more_ complicated.

There's really no reason why the Internet can't be secure everywhere at this point.

When it comes to making sure “old content” is still accessible by all, as someone who jumped on the HTTPS train as soon as they could, it would stand to reason that means for accessing this “old content” should be updated as well. Analog media is digitized to keep it accessible.

