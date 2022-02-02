---
layout: page
title: Links
---

A collection of links for things I find interesting on the Internet. Links are saved to my Randrop.io account. This page, when generated, pulls from my account and populates the list below.

<p class="text-center">
Jump to: 
{% for category in site.data.links.categories %}
  {% if category.links == blank %}
  <span class="text-muted">{{ category.name }}</span>
  {% else %}
  <a href="#{{ category.name | slugify }}">{{ category.name }}</a>
  {% endif %}{% unless forloop.last %} • {% endunless %}
{% endfor %}
</p>

<p class="text-center">
Total links: {{ site.data.links.total }}
</p>

{% for category in site.data.links.categories %}
<div data-category-id="{{ category.id }}" id="{{ category.id }}">
  <h2 id="{{ category.name | slugify }}">{{ category.name }}</h2>
  {% if category.links == blank %}
  <small>No links for this category</small>
  {% endif %}
  {% for link in category.links %}
  <p class="py-3 my-0 border-bottom">
    <strong><a href="{{ link.url }}" target="_blank">{{ link.title }}</a></strong> <code class="text-small text-muted">{{ link.from }}</code><br />
    {% for tag in link.tags %}
    <span class="badge rounded-pill bg-light text-dark">{{ tag }}</span>
    {% endfor %}
  </p>
  {% endfor %}
</div>
{% endfor %}