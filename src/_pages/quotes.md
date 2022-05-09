---
layout: page
title: Quotes
last_modified_at: 2022-05-08
description: Some quotes I enjoy.
slug: quotes
---

Just a collection of quotes I've stashed away that I enjoy.

Jump to: {% for category in site.data.quotes %}<a href="#{{ category[0] | slugify }}">{{ category[0] | capitalize }}</a>{% endfor %}

{% for category in site.data.quotes %}

<h2 id="{{ category[0] }}">{{ category[0] | capitalize }}</h2>

Jump to: {% for source in category[1] %}<a href="#{{ source.title | slugify }}">{{ source.title }}</a>{% endfor %}
{% for source in category[1] %}

<h3 id="{{ source.title | slugify }}"> {{ source.title }}</h3>
<ul>
  {% for quote in source.quotes %}
  <li>{{ quote }}</li>
  {% endfor %}
</ul>
{% endfor %}  
{% endfor %}
