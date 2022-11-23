---
# Feel free to add content and custom Front Matter to this file.

layout: default
last_modified_at: 2022-03-30T20:19:53.034Z
---

<h2>Latest Posts</h2>

{% render "post_loop", posts: collections.posts.resources, limit: 10 %}

<p>
  <a href="/posts/">All Posts <i class="far fa-long-arrow-alt-right"></i></a>
</p>
