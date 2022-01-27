---
layout: page
title: All Posts
---

This is a reverse-chronological list of every post on the site. There are over 400 posts spanning over seven years. 

Jump to year:&nbsp;{% for post in collections.posts.resources %}{%- assign currentdate = post.date | date: "%Y" -%}{%- if currentdate != date -%}<a href="#y{{ currentdate }}">{{ currentdate }}</a>&nbsp;{%- assign date = currentdate -%} {%- endif -%}{% endfor %}


{% for post in collections.posts.resources %}
{% assign currentdate = post.date | date: "%Y" %}
{% if currentdate != date %}
  <h2 class="text-center pt-5 pb-3 border-top" id="y{{currentdate}}">{{ currentdate }}</h2>
  {% assign date = currentdate %} 
{% endif %}
  {% render "post_loop" post: post %}
{% endfor %}
