---
layout: page
title: Links
---

A collection of links for things I find interesting on the Internet. Links are saved to my Randrop.io account. The data source is queried at 0:00 UTC every day.

<p class="text-center">
Total links: {{ site.data.links.total }}
</p>

{% for item in site.data.raindrop.reading_list.items %}
<p class="py-3 my-0 border-bottom" data-raindrop-item-id="{{ item.id }}" id="{{ item.id }}">
  <strong><a href="{{ item.url }}" target="_blank">{{ item.title }}</a></strong> <code class="text-small text-muted">{{ item.domain }}</code><br />
  {% for tag in item.tags %}
  <span class="badge rounded-pill bg-light text-dark">{{ tag }}</span>
  {% endfor %}
</p>
{% endfor %}