---
# Feel free to add content and custom Front Matter to this file.

layout: default
last_modified_at: 2022-02-06 14:30:00 -07:00
---

<h2>Johnathan Lyman</h2>
<p>I am a veteran Developer/Application Support Engineer turned Full Stack Developer. My background is Ruby and Ruby on Rails. This site is my digital landing zone where I opine on topics I find interesting, collect links to sites, books, and resources I find helpful, and highlight my professional experience.</p>

<p><a href="/about/">About me <i class="far fa-long-arrow-alt-right"></i></a></p>
<hr>
{% render "carbon" %}
<hr>
<h2>Latest Posts</h2>
<p>A list of the most recent five posts I've created.</p>
{% render "post_loop", posts: collections.posts.resources, limit: 5 %}

<p>
  <a href="/posts/">All Posts <i class="far fa-long-arrow-alt-right"></i></a>
</p>
<hr>
<p class="small text-muted">This site is entirely open-source. If anything is out of sorts, the repo is <a href="https://github.com/johlym/johnathan-org" target="_blank">here</a>.