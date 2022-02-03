---
title: 'SpinupWP: The Best Service for Deploying Self-Hosted WordPress'
slug: spinupwp-the-best-service-for-deploying-self-hosted-wordpress
feature_image: "/content/images/wp-content/uploads/2018/12/spinupwp_homepage.jpg"
featured: false
og_image: "/content/images/wp-content/uploads/2018/12/spinupwp_homepage.jpg"


layout: post
categories: posts
date: 2018-12-23 14:35:41.000000000 -08:00
---

Over the last 10-ish years, I've deployed more WordPress sites than I can count. If there's one service I could have used to make my life easier, it would have been an all-inclusive deployment tool that makes not only servers appear, but a complete and secure WordPress installation, too.

That's not to say that easy solutions don't exist. If you're a Digital Ocean user, you know WordPress-specific images are already a thing and only require a few clicks. The problem there is WordPress isn't configured with anything useful



like caching, and passwords are up to RNG.

This is where SpinupWP comes into play, built by the folks at Delicious Brains, makers of the [WP Migrate DB Pro](https://johnathan.org/goto/wpmigratepro) and [WP Offload Media](https://johnathan.org/goto/wpoffloadmedia) WordPress plugins. They build amazing plugins, so you know they built a great service, too.

SpinupWP does one thing really damn well: make servers with WordPress pre-installed and pre-configured appear on Linux servers. Out of the box, they hook up with Digital Ocean, but if you have your own box elsewhere, just feed them the IP address and credentials. They'll handle the rest.

For the sake of my review, we'll be focusing on Digital Ocean deployments, but most of what I cover is the same elsewhere.

## Part 1: Creating the Server

Creating a server starts simply: tell SpinupWP how large and where:

{% cloudinary_img "SpinupWP New Server page", "spinupwp_deployment_start-1024x626", "standard" %}
_The server setup page. This is where you'll feed things like passwords and database names._

At this stage, you'll provide things like the database name and it's password, as well as any SSH keys for access to the server from a Terminal. Make note of the password before continuing.

{% cloudinary_img "SpinupWP New Server feed", "spinupwp_deployment_status_clip.gif", "standard" %}
_The setup live feed._

Once all the details are plugged in, SpinupWP will take care of the rest. It starts by using the Digital Ocean API to create a server in the region you selected earlier and with the correct size. Once the server is up, SWP will update and patch the server, then deploy the version of PHP and MySQL you chose. This can take some time, so feel free to come back in a few minutes. They say it can take up to 10 minutes, and I found that often to be the case.

{% cloudinary_img "Alt text goes here", "spinupwp_site_deployment_complete-1-1024x626", "standard" %}
_The SpinupWP dashboard with a server ready to accept new WordPress sites._

Just the fact that you can go from zero to a fully-functioning and ready-to-go WordPress server without any sites is awesome. It gets even better when we get to the next half: creating WordPress sites in a few clicks.

## Part 2: Creating a WordPress Site

Creating the WordPresss site is also just as easy as the server itself and only requires a few bits of information:

Choose the PHP version and site type (single- or multisite):

{% cloudinary_img "Alt text goes here", "spinupwp_site_deployment_configuration_1-4-1024x473", "standard" %}
_Setting the PHP version and WordPress site type._

Name the database and its user and password:

{% cloudinary_img "Alt text goes here", "spinupwp_site_deployment_configuration_2-2-1024x611", "standard" %}
_Naming the database, setting the WordPress' database access username, and the user's password._

Name the site and create the admin user and its username and password:

{% cloudinary_img "Alt text goes here", "spinupwp_site_deployment_configuration_3-2-1024x711", "standard" %}
_Give the site a name, set the admin username, the admin email, and password._

And that's it! After a few minutes it'll appear on your dashboard:

{% cloudinary_img "Alt text goes here", "spinupwp_site_dashboard-2-1024x626", "standard" %}
_A complete, ready-to-go WordPress site._

Once the site is live, you'll be able to control certain aspects about it like SSL and caching settings. If the site ever needs to disappear, this is also where you'd delete it.

From end to end, this process takes about 20 minutes. If you're in the market to host an array of WordPress sites for clients or you have a lot of unique blogs you keep operating, this is the way to go. I'd even go so far as to say it's worth migrating your WordPress blog to a SpinupWP-created instance of WordPress just for the pre-configured caching and security hardening.

## Summary

This service is killer and priced very competitively. Since they're still fresh, everyone that signs up gets special pricing, starting at $6/month for the first three months with unlimited sites on one server or $9/month for the first three months with unlimited sites on up to three servers (+$5/month for every server thereafter). The fact that one can pay $6 to have a WordPress site appear in mere moments is awesome. If your goal is to only ever deploy one site, paying $6 for one month and cancelling is still absolutely worth it.

[Sign up for SpinWP right now](https://johnathan.org/goto/spinupwp) and safe yourself time and sanity. You'll be glad you did and even more, you'll wonder how you managed to deploy WordPress on servers before today.

