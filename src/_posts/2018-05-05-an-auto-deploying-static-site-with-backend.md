---
title: An Auto-deploying Static Site with Backend
slug: an-auto-deploying-static-site-with-backend
featured: false
og_title: An Auto-deploying Static Site with Backend – Johnathan.org
og_description: I have some nostalgia for static sites. I first learned to write any
  kind of code with HTML on a Packard Bell 486. I was hooked. Fast forward a couple
  years and
meta_title: An Auto-deploying Static Site with Backend – Johnathan.org
meta_description: A hand-crafted technology product by Johnathan Lyman
layout: post
categories: posts
date: 2018-05-05 17:00:00.000000000 -07:00
---

I have some nostalgia for static sites. I first learned to write any kind of code with HTML on a Packard Bell 486. I was hooked.

Fast forward a couple years and I was creating HTML sites in Allaire HomeSite (which became Adobe HomeSite and eventually Dreamweaver… R.I.P. HomeSite). It wasn’t long before I discovered CMSes–PostNuke, PHPNuke, TextPattern, MovableType, WordPress–I loved them all. Over the last half-decade though, WordPress was where I settled. The thought of going back to a static site was intriguing and I even tried it once, but I just couldn’t get it to stick.

Fast forward to now, where I’ve thrown WordPress to the side for a static option. I wrote this post to discuss my motivations behind it, especially after talking about–at length–why I left Ghost.org for WordPress.

## Moving Parts

Beyond all else my primary motivator was complexity. As much as I’d like to think this would change, I don’t blog often, nor do I have a highly complex blog that requires a lot of input by multiple people. Naturally, one might think about going to a hosted solution like WordPress.com or Squarespace. Both were options I toyed with in the past and turned down as serious options.

WordPress.com costs more money than I think it’s worth and Squarespace isn’t blog-centric. It’s a great product and you can build awesome sites that have blogs as a component, but it just doesn’t have that “this is your place to share your thoughts” vibe I’m looking for. Beyond that, I have almost 300 posts (it used to be closed to 340, but I purged a bunch that were so out-dated and broken it wasn’t worth saving them) and I didn’t feel like that much imported content is something SquareSpace could handle well.

This led me to self-host WordPress. I enjoy setting up and maintaining servers as much as the next person, but my bill was higher than it was worth. I had deployed two DigitalOcean droplets, one for the database and one for the web server. At $20 each, (4GB ram, 80GB SSD) it was getting pretty pricey. I could have scaled down and even put both functions into one server, but even then I wouldn’t have felt comfortable spending any less than $20.

I would vouch for [Digital Ocean](https://m.do.co/c/b3e840db07ba) all day long, though. They’re great people to work with–I know at least one of them personally–and their UI is prefect for my needs.

**Side note:** use that link and you’ll get $10 in credit when you sign up. That’s 2 months of their entry VPS (1GB RAM) for free.

I had to really think about my plan. If I was going to go back to static, I needed to pick a tool that I wouldn’t end up hating six months from now. My answer was actually several tools.

# The Toolkit

I came up with three pieces to complete my static site solution:

- Jekyll: it’s Well-known and something I’m very familiar with.
- [Circle CI](https://circleci.com): making sure what I’m pushing is legit and let me auto-deploy… no more git hooks)
- [Forestry.io](https://forestry.io): I like using editors as much as the next guy but if I have something I want to write about, taking the extra steps to push it up to GitHub isn’t going to cut it for me.

### Jekyll

Jekyll seemed like a no-brainer. Hugo was out of the question because I didn’t want to learn something new and others just weren’t full-featured enough. With my passable ruby and liquid knowledge, I could manipulate Jekyll to do what I want and not want to give up and throw it all away.

### Circle CI

Circle CI came late in the game. I was originally going to use Netlify to deploy and host my site but I didn’t like how little control I had. Yes, it’s free as in beer, but I didn’t have any kind of insight as to the performance or overall control. Beyond that, deployment took longer than I wanted, primarily because it spends time at the final stages checking the HTML for forms it needs to process and understand. Given that I have over 300 pages–probably more than 400, actually–that was a non-starter. I’d probably use Netlify at work, but not for this project.

By having an CI tool at the ready, I could have it build the Jekyll-based site for me, check the HTML for obvious problems, then push it to my server (in fact that’s what it does–minus the HTML checking part, that’s not ready).

### Forestry.io

Forestry.io is a tool I never heard of until a few weeks ago. It syncs with the GitHub repo that stores my site and allows me to create posts and pages, manipulate front matter templates, and do some basic media uploading. It’s not perfect, and on rare occasions it trips GitHub’s API rate limiting, but it’s been pretty solid overall. Support is good, and the free tier does exactly what I need it to, nothing more.

## Performance

With these three tools in play, I have what amounts to a static site-CMS hybrid. When I click Publish on this post, Forestry will push it into my GitHub repo. From there, Circle CI will trigger when it sees a change and run my build script. The last step of that script is to `rsync` the built HTML site over to my server.

On my server, I have Nginx serving the pages with some effective caching and it’s smooth. By extracting WordPress and it’s PHP+MySQL clusterfest, I’ve also been able to improve load times both in the context of first-byte and the entire page.

My PageSpeed and YSlow scores are better than they used to be when running WordPress. There’s room for improvement but overall, it’s turning out pretty well when I consider the fact that I haven’t gone out of my way to make them great.

One thing I really need to work on, though, is my Lighthouse performance. This is what I would say is going to be the successor to PageSpeed. It’s really tough on sites and my performance as it’s measuring is dismal. Some of that might be the extensions Chrome is running and removing them speeds things up a bit, but I definitely have some front-loading I need to do of critical CSS and moving the rest to the back.

Overall, though, I’m happy with how things are operating. Forestry is fast, the whole thing can be done for $5, and I can feel good knowing that my site can’t be taken over thanks to a &nbsp;vulnerability in WordPress.

