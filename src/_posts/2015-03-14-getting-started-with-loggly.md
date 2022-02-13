---
title: Getting Started with Loggly
featured: false
layout: post
categories: posts
date: 2015-03-14 17:12:11 -07:00
last_modified_at: 2022-02-06 14:00:00 -07:00
---

I love logs. I love massive amounts of data. I have this thing where if I feel I can consume and process tons of data by doing something menial and useless, I'll do it.

One thing I don't really do though is keep tabs on the logs for my site and its services. This is where [Loggly](http://loggly.com) comes in, and this is my experience getting it set up.

Signing up was pretty easy. I just went to [loggly.com](http://loggly.com), clicked Sign Up in the top right corner, filled out a few things, and waited patiently while their systems used magic fairy dust and unicorn blood to construct my logging instance. They provide a full 30-day trial that gives a user full access to all features to determine if it's really right for them. After 30 days, it drops down to their limited free tier, which is still good for small people like me.

I'm writing this as I go through their service, so let's take a moment to talk about what Loggly actually does.

The whole goal of Loggly is to provide centralized log management without the need for agents. This allows sysadmins or anybody who cares to view and track log data in real time. You can search through logs as they come in and graph out instances of particular events to track down issues as they're happening.

Logy allows you to track logs from almost any source. Their list is pretty exhaustive if you ask me:

- Windows
- Linux
- Apache
- Nginx
- IIS
- JavaScript
- Tomcat
- MySQL
- Microsoft SQL Server
- Rails
- Python
- Django
- MongoDB
- PHP
- Java
- Ruby
- Node.JS
- .NET
- Docket
- Puppet
- Chef
- FluentD
- AWS Cloudtrail
- AWS S3
- and Heroku

That really is a pretty big list.

I mentioned that you can get started for free than that there's a free tier, but let's talk about what that actually means and the other options that are available.

The free tier gives you the basics including searching and filters, persistent workspaces, and built-in alerting. The standard tier ($49/month) gives you 1GB/day of log storage and 7-day retention, unlimited users, built-in alerting, customized dashboards, and more.

Moving to the Pro tier is where you start getting some of the more tasty features. &nbsp;You get peak overage protection, AWS S3 archiving, telephone support, and more. The default plan grants 15 days of retention at $109/month, but if you need more than that, you're more than welcome to it: 10GB/day for $499, 50GB/day for $2500 and more. If 50GB/day and $2500 sounds like a lot, don't worry, it is. 50GB of log files in a day though is a lot and if you need that kind of support, you're not too worried about the price.

[The second half of this post](/getting-started-with-loggly-part-2-the-cool-stuff/) is to follow after my account is set up… see you soon!

