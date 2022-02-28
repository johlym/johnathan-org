---
title: Easy Redirect Links Within Jekyll
featured: false
layout: post
date: 2018-05-06 17:00:00 -07:00
last_modified_at: 2022-02-28T23:28:56.270Z
category: programming
---

I am buttoning up the final touches on my new Jekyll-powered blog. One thing I wanted to attempt without having to spin up yet another app or service was short link redirects.

My goal was to be able to take `http://johnathan.org/goto/something` and have it redirect to a full URL of my choice. Jekyll is trigger happy with creating a page for everything. I knew I had to find some way to manage the data long term.

Forestry offers the ability to manage arbitrary data sets within Jekyll. Since I'm using it, I knew it was going to be a breeze so that's the path I took.

I first started by creating a new file in the `_data` folder called `shortlinks.yml`. Anything I plug into this YAML file becomes an extension of the `site` object. My data file has three fields per entry: `title`, `key`, and `destination`. The `title` and `destination` are self-explanatory. The `key` is the short URL keyword. This is what we'll use after `/goto/` in the path.

Having these fields in mind, my `shortlinks.yml` would look something like this:

```yml
- title: A cool page
  key: coolpage
  destination: https://google.com
- title: A mediocre page
  key: mehpage
  destination: https://bing.com
```

This means I can now access my links under the `site.shortlinks` array by iterating over it. Unfortunately, we still have a bit of a roadblock. Since everything about Jekyll is static, I can't create a dynamic page that would access the data. Wwll, I could, like something in PHP, but I don't want to. &nbsp;Instead, we'll have to use the data as a base for a set of pages we'll create that act as redirects.

This is like how Jekyll Collections work, except we don't want to create the pages ahead of time, only on `jekyll build`. This is where [`data_page_generator.rb`](https://github.com/avillafiorita/jekyll-datapage_gen) comes into play. By placing it in_ `_plugins` and feeding it a few settings in `config.yml`, we can instruct it to build pages based on `shortlinks.yml`.

That code would look something like this:

```yml
page_gen:
  - data: shortlinks
    template: redirect
    name: key
    dir: goto
```

Seems easy enough. Let's break it down. `data` is the data file we want to use. It makes assumptions about the file type. `template` directs the plugin what base template to use. &nbsp;What that template looks like is in the next section. `name` is the `key` from earlier. This is the file name that we create within the `dir` directory. In this example, the redirect files land as `_site/goto/key.html_`_, provided the base directory is_ `_site`.

Now that we have the configuration squared away, we need to create an `_includes/redirect.html` template. Since we're doing immediate redirects, it doesn't need to be fancy, nor does it need to have style. This will do:

```html
<!DOCTYPE html>
<html lang="en">

<head>
  <meta http-equiv="refresh" content="0; url={{ page.destination }}" />
  <script type="text/javascript">
    window.location.href = "{{ page.destination }}"
  </script>
  <title>Redirecting...</title>
</head>

<body>
  Redirecting to {{ page.destination }}. If it doesn't load, click <a
    href="{{ page.destination }}" />here</a>.
</body>

</html>˝
```

`data_page_generator.rb` will take each object in the data file and pump the values into this template. In our example, we're only interested in `destination`.

With our template set, there's one last thing we need to do.

You might need to make a tweak to convince it that `/goto/something` and `/goto/something.html` are alike and not return a `404 (dependent on your Webserver configuration). In my case with Nginx, all I had to do was swap:

```
location / {
    try_files $uri $uri/ =404;
}
```

with

```
location / {
    try_files $uri $uri.html $uri/ =404;
}
```

For those following along at home, all I added was `$uri.html`. What we're doing is instructing Nginx to take the presented URI–in the case of `/goto/something`, the URI is `something` and try it against `something` by itself, then `something.html` (this is what we've added), and finally `something/` before giving up and looking for a 404 page. If it matches something, try to render it no matter what.

Now, we can push everything and give it a go. In my real-world example, I have a couple links already set up as I write this. My new favorite air purifier/filtration system is [Molekule](https://johnathan.org/goto/molekule) so clicking that link will take you straight there.

Long-term, I'm uncertain about this solution's long-term scalability. This will be fine on the scale of a few hundred links as Jekyll can turn through a few hundred pages in a matter of seconds (especially when paired with Ruby `>= 2.5.x`). How well this works long term will come down to a couple things:

- The effort required to manage the data file
- The tools in place to automate the building of the Jekyll site

For the latter, I use Circle CI so I'm fine with it taking a handful of seconds or even a half-minute longer to update. For the former, I use Forestry. I haven't pushed it to the point where it has several hundred items in the `shortlinks.yml` data file. The limits of its capability are unknown in this regard.

My alternative plans were to move to Bit.ly (using a short domain of some sort) or setting up [Polr](https://polrproject.org) on the server. I'll have to spend some time thinking about how I can track clickthroughs. As I wrapped this up, I pondered plopping Google Analytics on the redirect page. This allows me to measure the movements into `/goto` pages as clicks.

I'm happy with how this turned out. Like all things I do, there'll be persistent tweaking involved.

