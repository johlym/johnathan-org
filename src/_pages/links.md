---
layout: page
title: Links
last_modified_at: 2022-02-06 14:30:00 -07:00
isModifiedDate: 2022-04-03T17:56:21.418Z
---

Collections of links for things I find interesting on the Internet, broken out by category.

<p class="text-center">
{% for category in site.data.raindrop %}
 <a href="#{{ category[0] }}">{{ category[0] | replace: "_", " " | titleize }}</a>{% unless forloop.last %} • {% endunless %}
{% endfor %}
</p>

{% for category in site.data.raindrop %}
<h2 id="{{ category[0] }}">{{ category[0] | replace: "_", " " | titleize }}</h2>
  {% for item in category[1].items %}
  <p>
    <a href="{{ item.link }}" target="_blank"><strong>{{ item.title }}</strong></a><br />
    {{ item.domain }} ({% for tag in item.tags %}{{ tag }}{% unless forloop.last %}, {% endunless %}{% endfor %})
  </p>
  {% endfor %}
{% endfor %}

