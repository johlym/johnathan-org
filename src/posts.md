---
layout: page
title: All Posts
---

This is a reverse-chronological list of every post on the site. There are over 400 posts spanning over seven years. 

<ul class="list-unstyled pl-0">
  {% for post in collections.posts.resources %}
    <li class="border-top">
      {% render "post_loop" post: post, excerpt: "true" %}
    </li>
  {% endfor %}
</ul>
