---
layout: page
title: Archive
---

This is a reverse-chronological list of every post on the site. There are over 400 posts spanning over 7 years. 

Jump to year:&nbsp;{% for post in collections.posts.resources %}
{%- assign currentdate = post.date | date: "%Y" -%}
{%- if currentdate != date -%}
  <a href="#y{{ currentdate }}">{{ currentdate }}</a>&nbsp;
  {%- assign date = currentdate -%} 
{%- endif -%}
{% endfor %}

<ul class="post-list">
  {% for post in collections.posts.resources %}
  {% assign currentdate = post.date | date: "%Y" %}
  {% if currentdate != date %}
    <h2 id="y{{currentdate}}">{{ currentdate }}</h2>
    {% assign date = currentdate %} 
  {% endif %}
    <li>
      {% assign d = post.data.date | date: "%d" | plus:'0' %}
      {{ post.data.date | date: "%B" }} 
      {% case d %}
        {% when 1 or 21 or 31 %}{{ d }}st
        {% when 2 or 22 %}{{ d }}nd
        {% when 3 or 23 %}{{ d }}rd
        {% else %}{{ d }}th
        {% endcase %} <a href="{{ post.relative_url }}">{{ post.data.title }}</a>
    </li>
  {% endfor %}
</ul>