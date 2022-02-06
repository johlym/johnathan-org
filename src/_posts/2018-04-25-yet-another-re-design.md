---
title: Yet Another Re-design
slug: yet-another-re-design
featured: false
layout: post
categories: posts
date: 2018-04-25 17:00:00 -07:00
last_modified_at: 2022-02-06 14:00:00 -07:00
---

If you had asked me a few weeks ago if I would be re-doing my blog again, I'd think you're nuts.

You'd be right, though.

Through the process of making this version happen, there were several occasions where I pondered if I even wanted to do this. _WordPress is working fine_, I kept telling myself. That's not an untrue statement.

I wasn't happy with the overall look and feel, though, and I dreaded the idea of spinning up another development environment to re-create the theme. I hated creating the last one. It was always so complicated and [PHP is a shitbox](https://whydoesitsuck.com/why-does-php-suck/).

Recent professional experiences suggested I give Jekyll another go. It's been a couple years since I attempted to shovel my blog content through it. Over that time period, Jekyll got faster and Ruby as well. Last time I was running this blog through Jekyll, I had to set up git hooks to do stuff after I made changes. ~~Now, I can consider the likes of [Netlify](https://www.netlify.com) to take care of the heavy lifting for me.~~ I added auto-deployment functionality by way of Circle CI so every time I push a change, the rendered site is `rsync`ed to my DigitalOcean server.

[Heroku](https://heroku.com) was on the table as I've had more experience with them and they're good people, but they have a hard limit on app size of 500MB. I have a lot of images and I haven't figured out how to offload those to S3 exclusively so they're out of the running.

I could probably trim down the image quantity and size, but where's the fun in that? Not to mention I'd always have the looming 500MB limit over my head. Netlify doesn't seem to have that.

The final decision hasn't been made yet as to whether I use Netlify or if I take another crack at self-hosting. What makes the decision hard(er) is that also since I last tried all this, [Forestry](https://forestry.io) became a thing. I love the concept of a static site/GUI combination and Forestry handles the GUI content creation piece wonderfully. It's snappy, clean, and does one thing well.

I'll have some contemplations in which to engage and some testing to do, but I suspect I already know where things are at least heading… and that's away from WordPress… and PHP… and that terrible templating system. _Viva la Liquid_.

