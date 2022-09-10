---
layout: page
title: About Me
last_modified_at: 2022-02-06 14:30:00 -07:00
---

<p class="text-center">
  <a href="#introduction">Introduction</a> • 
  <a href="#work-history">Work History</a> • 
  <a href="#certifications">Certifications</a> • 
  <a href="#colophon">Site Colophon</a>
</p>

## Introduction

Born and raised in the Pacific Northwest. I'm a developer that cut his teeth supporting other developers in a vareity of environments. 

I grew up here in the Puget Sound and currently reside here with my wife and soon to be daughter. We have two cats. I earned my bachelor's degree from Western Governor's University in 2018. 

In the past I've been known to host a podcast, and run three side businesses to keep my mind fresh. One relates to [coffee](https://kenmorecoffee.com), another [candles](https://cascadehandcrafts.com), and the third is a holding company for tracking earnings and revenue from my occasionally-updated [e-commerce blog](https://sellerjournal.com).

This is year six (2016-2022) of working 100% remote and I've been able to use that time to really hone my [work space](/using/). 

## Work History

{% for job in site.data.work %}
<p class="py-3 my-0 border-bottom"><strong>{{ job.title }}</strong><br />{{ job.company }} - {{ job.start_date }} to {{ job.end_date }}</p>
{% endfor %}

## Certifications

{% for cert in site.data.certifications %}
<p class="py-3 my-0 border-bottom">
  <strong>{{ cert.title }}</strong> <span class="text-small text-muted">{{ cert.date }}</span><br />
  <span class="badge rounded-pill bg-dark text-light">{{ cert.body }}</span> <span class="badge rounded-pill bg-light text-dark">{{ cert.specific_to }}</span>
</p>
{% endfor %}

## Colophon

Johnathan.org is operated, maintained, and written by myself, Johnathan Lyman. I’ve maintained this blog to varying degrees since 2014 and have been on the web in about two dozen different formats since 2001-ish. Johnathan.org is my personal blog, first and foremost, where I write about topics that interest me. In particular, technology, some current events, videos, and other bits I discover are what you’re most likely to see here.

Since 2014, I’ve created almost over 400 posts. About 350 of them (as of mid-September 2018) have made it through the various transitions this site has seen. A few of them were so highly irrelevant or didn’t make sense. In hindsight, keeping them around seems like the right thing to do, but I’ve opted to move forward.

### Hosting, Toolchain, Standards

Johnathan.org is a statically generated site, built using [Bridgetown](https://github.com/bridgetownrb/bridgetown). For more on the tools I use on regular basis, check out [this page](/using). 

Everything should look fine on all modern mobile devices and browsers. Anything older like IE11 or from multiple years ago might have a bad time, and that’s on you. Update your stuff. If you’re using a current browser or mobile device and finding Johnathan.org difficult to navigate, let me know here.

### Advertising

Currently, ads are served exclusively through [Carbon](https://www.carbonads.net). To advertise on this site, please get in touch with them.

## Contact

If you need or want to get in touch, find me on twitter <a href="https://twitter.com/_johlym">@_johlym</a> or send me an email: `email at johnathan dot org`.