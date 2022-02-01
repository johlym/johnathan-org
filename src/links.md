---
layout: page
title: Links
---

These categories of links are generated using my Raindrop.io account.

{% for group in site.data.links %}
<div data-category-id="{{ group.id }}" id="{{ group.id }}">
  <h2>{{ group.category }}</h2>
  {% for link in group.links %}
  <p class="py-3 my-0 border-bottom">
    <strong><a href="{{ link.url }}" target="_blank">{{ link.title }}</a></strong><br />
    {{ link.excerpt }}
  </p>
  {% endfor %}
</div>
{% endfor %}