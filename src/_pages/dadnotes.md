---
layout: page
title: Dad Notes
last_modified_at: 2022-03-30T20:15:26.366Z
description: A collection of notes I've taken since having our first child.
slug: dad-notes
---

<!-- @format -->

This is a collection of notes I've taken since our first child was born. While always incomplete, it's helpful for me to look back at as she ages and hopefully someone else finds these bits helpful, too.

## Notes

<ul>
{% for note in site.data.dadnotes.notes %}
  <li>{{ note }}</li>
{% endfor %}
</ul>

## Stats

Vaguely tracking a few things.

### Diapers

#### Counts

- Total: {{ site.data.dadnotes.stats.diapers_total }}
- DPD: {{ site.data.dadnotes.stats.diapers_per_day }}

#### By Size

<ul>
{% for dc in site.data.dadnotes.stats.diapers_by_size %}
  <li>Size {{ dc[0] }}: {{ dc[1] }}</li>
{% endfor %}
</ul>
