---
layout: page
title: Links
last_modified_at: 2022-02-06 14:30:00 -07:00
isModifiedDate: 2022-04-03T17:56:21.418Z
---

Collections of links for things I find interesting on the Internet, broken out by category.

<p class="text-center">
{% for category in site.data.raindrop %}
 <a href="#{{ category[0] }}">{{ category[0] | replace: "_", " " | titleize }}</a>&nbsp;
{% endfor %}
</p>

{% for category in site.data.raindrop %}
<h2 id="{{ category[0] }}">{{ category[0] | replace: "_", " " | titleize }}</h2>
  {% for item in category[1].items %}
  <div class="card mb-3" data-raindrop-item-id="{{ item.id }}" id="{{ item.id }}">
    <div class="row g-0">
      <div class="col-sm-2 card-img-bg"
        style="{% if item.cover %}background-image: url('{{ item.cover }}'){% else %}background-color: #eee;{% endif %}">
        <!-- <img src="{{ item.cover }}" class="img-fluid rounded-start link-card-image"> -->
      </div>
      <div class="col-sm-10">
        <div class="card-body">
          <h5 class="card-title"><a href="{{ item.link }}"
              target="_blank">{{ item.title }}</a></h5>
        </div>
      </div>
      <div class="card-footer text-muted">
        <div class="row">
          <div class="col-sm-6">
          {% for tag in item.tags %}
          <span class="badge rounded-pill bg-dark text-light"
            data-raindrop-item-tag="{{ tag }}">{{ tag }}</span>
          {% endfor %}
          </div>
          <div class="col-sm-6 text-end">
            <p class="small text-muted font-monospace m-0">{{ item.domain }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
  {% endfor %}
{% endfor %}

