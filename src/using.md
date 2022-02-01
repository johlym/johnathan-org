---
layout: page
title: Tools I Use
---

{% for category in site.data.using.categories %}
<h2>{{ category.name }}</h2>
{% if category.categories %}
{% for sub in category.categories %}
<h3>{{ sub.name }}</h3>
<ul>
{% for item in sub.items %}
  <li>{% if item.class %}{{ item.class }}: {% endif %}{% if item.url %}<a href="{{ item.url }}" rel="noopener" target="_blank">{% endif %}{{ item.title }}{% if item.url %}</a>{% endif %}</li>
{% endfor %}
</ul>
{% endfor %}
{% else %}
<ul>
  {% for item in category.items %}
  <li>{% if item.class %}{{ item.class }}: {% endif %}{% if item.url %}<a href="{{ item.url }}" rel="noopener" target="_blank">{% endif %}{{ item.title }}{% if item.url %}</a>{% endif %}</li>
  {% endfor %}
</ul>
{% endif %}
{% endfor %}

<p class="small text-muted">This list may contain affiliate links and as such, I may make a commission from the purchase of goods using said links.</p>
