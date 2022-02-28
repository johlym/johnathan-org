---
title: Busting Cloudflare Cache when Posting to WordPress via XML-RPC
featured: false
layout: post

date: 2018-10-12 08:51:29 -07:00
last_modified_at: 2022-02-28T22:57:04.885Z
---

I love [Cloudflare](https://cloudflare.com). I'll come right out and say that now. It's a great service and makes for incredibly performant sites if used right (aggressively). I don't feel like I'm getting the most out of it until it's caching just about everything possible. Most of my content is static and never changes (save for the home page and each paginated set of posts thereafter). Even then, the homepage changes maybe a couple times a day. It makes a lot of sense for Cloudflare to cache them all. I use pretty aggressive Page Rule-based caching to accomplish that.

Part of my regular blogging workflow involves posting using MarsEdit. It's a great tool and uses XML-RPC to post content. One of the problems with this workflow is that most caching-management plugins for WordPress don't consider any kind of content changes via XML-RPC, only via the WordPress Admin UI. This means that there's virtually no support for engaging all the cache-cleaning activities when XML-RPC events take place and thus Cloudflare is never notified for purging.

Luckily, there's a solution to this problem. It involves a bit of duct-tape-like hooking into core WordPress, but in my testing, it's been pretty painless, and posting doesn't seem to be noticeably slower (XML-RPC posting takes a few seconds, anyway, adding another second isn't a big deal, in my opinion). All we need to do is add a filter to `xmlrpc_publish_post`.

Sounds easy, you say? It is!

```php
function clear_cache() {
$curl = curl_init();
curl_setopt ($curl, CURLOPT_URL, CACHE_PURGE_URL);
curl_exec ($curl); curl_close ($curl);
}

add_filter( 'xmlrpc_publish_post', 'clear_cache');
```

I set `CACHE_PURGE_URL` in `wp-config.php` to be a local path that when triggered with a GET request, makes a POST request that looks like the equivalent of this CURL request:

```sh
curl -X POST "https://api.cloudflare.com/client/v4/zones/YOUR_ZONE_ID/purge_cache" \
-H "X-Auth-Email: YOUR_EMAIL_ADDRESS" \
-H "X-Auth-Key: YOUR_API_KEY" \
-H "Content-Type: application/json" \
--data '{"purge_everything":true}'
```

Replace `YOUR_ZONE_ID`, `YOUR_EMAIL_ADDRESS`, and `YOUR_API_KEY` and you're set.

By making this request after `xmlrpc_publish_post` using `add_filter()`, we've already established our updated content so the trigger will have Cloudflare pull the freshest and not accidentally re-pull stale bits.

Right now, it's an entry in my theme's `functions.php`. If I was to do this truly right, I'd make this a plugin. Someday!

