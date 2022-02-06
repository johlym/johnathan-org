---
title: Blogging, Statically Speaking
slug: blogging-statically-speaking
featured: false
layout: post
categories: posts
date: 2016-05-28 19:43:55 -07:00
last_modified_at: 2022-02-06 14:00:00 -07:00
---

The concept of blogging using a staic site generator isn't news. People have been doing such things for years, now. There are fantastic static site generators out there ([Jekyll](https://jekyllrb.com), [Hugo](https://gohugo.io), [Pelican](http://blog.getpelican.com) to name a few) and all have their unique features, quirks, and _ugh_ moments.

I wrote a post a wrote a post a while back about moving over to Jekyll from WordPress. Within a couple weeks or so, I had moved back. I never posted why, but the reason boiled down to the generation time. It took Jekyll upwards of 90 seconds to two minutes to generate every time I wanted to updated something–anything, really. New to Jekyll 3, the `--incremental` argument didn't do anything and I wasn't comfortable leaving Jekyll running in `--serve` mode in the background.

Needless to say my views on running this blog with a static site generator are a little jaded. Recently the idea of using Hugo (written in Go) was suggested and I gave it a whirl. Go was wasy easier to set up and get running. I also found myself looking at several front-end UIs that can be bolted onto Hugo so I don't have to edit `.md` files all over the place then work out some git magic to push changes and have them be re-deployed.

There was one component that I just couldn't get into this potentially new workflow, though, and that was integrating any of my writing apps without having to also introduce manually saving an editing. I use Desk for writing my blog posts, including this one, and it does a killer job. Within a few clicks, my post is live and I didn't have to `git push` a damn thing.

Really it seems as though I'm torn. I like the idea of speed and simplicity. I like the idea of not having to maintain a MySQL database and PHP. I don't like the idea of trading that work (something I'm already super familiar with and have down pretty well for my needs) for a different kind of maintenance. I can deal with maintaining a server, but if it takes more than minimal effort to get a blog post up, I'm not sure I'd be interested in the alternative.

Did I mention the migration? Never have I ever had my 270 something (as I post this) posts all move over without at least moderate tweaking required. At this point, the amount of effort required to transition would negate any savings. And I'm kind of lazy.

I doubt I'm the only one that feels this way and I'm sure there are a ton of other ways to go about solving this problem. I might never go back to a static site generator, again, and I'm ok with that. If WordPress becomes faster, hooray! If it is no longer written in PHP, I'd feel even better about it. In the meantime, I'll continue doing things the way I've done them since January 2015, almost 18 months ago.

