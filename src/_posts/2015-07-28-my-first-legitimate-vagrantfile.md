---
title: My First Legitimate Vagrantfile
slug: my-first-legitimate-vagrantfile
featured: false


layout: single_post
categories: posts
date: 2015-07-28 18:41:23.000000000 -07:00
---

I feel like I've created this sort of new kind of being. Previously, I had rarely used Vagrant or Docker or anything of the sort, so the idea of being able to craft an on-demand virtual machine with whatever the hell I want inside of it was both exciting and terrifying.

Linux isn't foreign to me, and neither is the idea of automation, but after being so accustomed to working in a Windows environment against my better judgement for several years, there was a lot of cobweb removal.

Needless to say I could have prevented the aging of my knowledge by staying up to date on every development and deployment technology I could get my hands on. There are, however, only so many hours in the day. Something had to give.

Now I'm paying for that decision as I work on slowing transitioning myself into a more software-development oriented career path. I enjoy ops-y stuff, but I like building things. I like tinkering (hacking?). My boss made a joke today about how involved I get whenever there's a discussion about minor HTML tweaks to one of our sites.

Hey… I like that s–t.

One thing that made it easier for me to get into this new and soon-to-be-awe-inspiring technology is that I had a purpose. There was a clear goal I wanted to meet and beat.

One of our software offerings runs on JIRA. If you're unfamiliar with the product, it's a Java-based project management/issue tracking/development/agile tool for organize and keep track of just about anything. Software companies and app development teams are likely the largest consumers of this product. On a regular basis, my team is spinning up and burning down JIRA instances in the never-ending hunt for bug reproduction, walkthroughs, and everyday troubleshooting.

Unfortunately, installing JIRA by hand isn't fun if you're running a Linux box. The Windows installer is pretty hands-off but Windows is Windows.

My end goal was to be able to fire up the almighty Vagrant, have it build out a Linux image with a database, JIRA, and be ready to accept input in the browser. I piggy-backed off a couple other like-minded setups I found on GitHub so it only took a couple hours to get it doing what I wanted.

So without further ado, [here's the link](http://github.com/johlym/vagrant-jira-mysql). It's a work in progress as I'd like to someday have data pre-filled and JIRA pre-installed. I'm not sure how feasible that is given JIRA's licensing structure. For the uninitiated, the license key is unique and time-based. The key starts to wither away the moment its generated instead of the system stopping working after 30 days from install.

Next week I might try the same with Docker. I'd love to be able to manage a cluster of these types of setups that can be built up and torn down as needed with little overhead. Instead of making the pre-game ritual longer, I want to make it shorter but more enjoyable.

