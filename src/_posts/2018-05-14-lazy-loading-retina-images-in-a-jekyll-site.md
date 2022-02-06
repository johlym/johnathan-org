---
title: Lazy-loading Retina Images in a Jekyll Site
slug: lazy-loading-retina-images-in-a-jekyll-site
featured: false
layout: post
categories: posts
date: 2018-05-14 22:00:00 -07:00
last_modified_at: 2022-02-06 14:00:00 -07:00
---

Something I've wanted to touch on ever since a couple posts ago was lazy loading images. Now that I'm trying to consciously serve 2x images for those with such a pixel density, I'm setting myself up for increased page loads and folks may never even make it that far down the page. Since there's no need to load what one won't see, I set out to add lazy image loading support to the blog.

This really doesn't apply specifically to Jekyll, in fact there's nothing about this that's unique to Jekyll but during my searches, I initially felt I needed to find a Jekyll plugin to solve this problem. Since I had that idea, I'm certain others will, too, so I want to catch as many of those folks as I can and let them know it's easier than that!

As far as the JavaScript goes, I'm using the vanilla-JavaScript-based [lazyload.js](https://github.com/verlok/lazyload). I just need to toss it into the footer (no point in loading it before everything else, which technically means we're lazy-loading the lazy-loader):

```js
<script>
  (function(w, d){
    var b = d.getElementsByTagName('body')[0];
    var s = d.createElement("script"); s.async = true;
    var v = !("IntersectionObserver" in w) ? "8.7.1" : "10.5.2";
    s.src = "https://cdnjs.cloudflare.com/ajax/libs/vanilla-lazyload/" + v + "/lazyload.min.js";
    w.lazyLoadOptions = {}; // Your options here. See "recipes" for more information about async.
    b.appendChild(s);
}(window, document));
</script>
```

What we're doing here (courtesy of the [lazyload.js](https://github.com/verlok/lazyload) documentation) is selecting the best version of it based on the browser. Version 8.x plays better with everything and since not all browsers support [IntersectionObserver](https://caniuse.com/#feat=intersectionobserver), it's important to be backwards compatible. Version 10.x will load for Firefox, Chrome and Edge, while 8.x will load for pretty much everything else.

Now that our JavaScript is in play, the only other step is to update the image tags. I have a TextExpander snippet to help me out here, since I'm also inserting retina (@2x) images. It looks like this:

```
![](){: data-src="%filltext:name=1x image%" data-srcset="%filltext:name=2x field% 2x" data-proofer-ignore}](%filltext:name=full image%){: data-lightbox="%filltext:name=lightbox tag%"}
```

This creates four fields, the paths to the 1x small image 2x small image, the full-size image loaded and the tag needed by [lightbox.js](http://lokeshdhakar.com/projects/lightbox2/). The finished markdown product looks like this (taken from a previous post):

```
![](){: data-src="/assets/images/2018/05/07/gtmetrix-0512-sm.jpg" data-srcset="/assets/images/2018/05/07/gtmetrix-0512-sm@2x.jpg 2x"}{: data-lightbox="image-3"}
```

Pretty slick, eh? With this in place, some bytes will be saved every day.

You might have noticed the data-proofer-ignore attribute. That's to keep htmlproofer from tripping over these images because they have no src or srcset attributes defined. It'll essentially skip them during its check. The downside is if I need to do an audit on images, I'll have to bulk eliminate data-proofer-ignore at least temporarily.

Once this is all said and done, let the better test results come pouring in!

