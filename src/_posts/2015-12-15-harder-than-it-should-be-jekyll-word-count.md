---
title: 'Harder Than it Should Be: Jekyll Word Count'
slug: harder-than-it-should-be-jekyll-word-count
featured: false
og_title: 'Harder Than it Should Be: Jekyll Word Count – Johnathan.org'
og_description: When I was running this site through WordPress, I had a plugin that
  would count the number of words each of my posts contained and give me some metrics.
  It was
meta_title: 'Harder Than it Should Be: Jekyll Word Count – Johnathan.org'
meta_description: A hand-crafted technology product by Johnathan Lyman
layout: post
categories: posts
date: 2015-12-15 09:51:22.000000000 -08:00
---

When I was running this site through WordPress, I had a plugin that would count the number of words each of my posts contained and give me some metrics. It was a pretty slick plugin and had all sorts of visuals.

With Jekyll, I don’t have such capabilities out of the box (or even remotely close to the box) so I went hunting for a plugin. I found one, and it works, but it’s slow, and I don’t really think there’s much that can be done about it. Given the static nature of Jekyll, it’s not really easy to save persistent information somewhere like in a database without also having a plugin for the database.

The plugin brought down my build to a crawl (140s over 13s) and GitHub didn’t whitelist the plugin, so it was pretty much a non-starter.

Needless to say, I pulled it, but if you want to see the commit where I added it, go [here](https://github.com/jelyman2/jelyman2.github.io/commit/004b155426b3cd8cb08316c7e6941562baa1075d) (then the subsequent commits [here](https://github.com/jelyman2/jelyman2.github.io/commit/89bf68b99961afb38a251c148744cdadba936dbd) and [here](https://github.com/jelyman2/jelyman2.github.io/commit/7bdf194867708871df67037e89e34679643ad1ba). [Here](https://github.com/jelyman2/jelyman2.github.io/commit/a4ed6e097b9bbe86ef12453704a8e419ee3a0eed)’s where I pulled it).

For the record, before this post: 92,205 words. With this post: 92,392 words.

