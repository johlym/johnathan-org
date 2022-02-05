---
layout: page
title: Links
---

A collection of links for things I find interesting on the Internet. Links are saved to my Randrop.io account. The data source is queried at 0:00 UTC every day.

<p class="text-center">
Total links: {{ site.data.raindrop.reading_list.count }}
</p>

{% for item in site.data.raindrop.reading_list.items %}
<div class="card mb-3" data-raindrop-item-id="{{ item.id }}" id="{{ item.id }}">
  <div class="row g-0">
    <div class="col-md-4">
      <img src="{{ item.cover }}" class="img-fluid rounded-start link-card-image">
    </div>
    <div class="col-md-8">
      <div class="card-body">
        <h5 class="card-title"><a href="{{ item.url }}" target="_blank">{{ item.title }}</a></h5>
        <!-- <p class="card-text">This is a wider card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p> -->
        <p class="card-text"><code class="text-small text-muted">{{ item.domain }}</code></p>
      </div>
      <div class="card-footer text-muted">
        {% for tag in item.tags %}
        <span class="badge rounded-pill bg-light text-dark" data-raindrop-item-tag="{{ tag }}">{{ tag }}</span>
        {% endfor %}
      </div>
    </div>
  </div>
</div>
{% endfor %}