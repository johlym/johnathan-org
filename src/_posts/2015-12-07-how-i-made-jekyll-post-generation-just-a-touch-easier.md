---
title: How I Made Jekyll Post Generation Just a Touch Easier
featured: false
layout: post
categories: posts
date: 2015-12-07 09:44:26 -08:00
last_modified_at: 2022-02-06 14:00:00 -07:00
---

Now that I'm running my blog using Jekyll, one thing I've already found to be rather frustrating is the post generation process. I have a blank `.md` template I open, save in a new location, then edit, but that seems cumbersome, to me. What I decided to do instead is write a quick Ruby script that generated a post `.md` file for me based on the information I provide.

## Thought Process

I wanted to keep it simple, and just do only what I really needed. I don't need any fancy logic or checking. I know `_posts` will be there because I put `post_generator.rb` inside my Jekyll directory.

## Working Example

Here's my code as it stands inside right now:

```css
.gist table { margin-bottom: 0; }
```

It's functional. It's not clean and could be refactored a but, but it works.

## Improvements

A few things that came to mind after I finished: – Use the system date if none is provided – Re-format the title with title-casing. Without `ActiveSupport` in Rails, I'll have to either require it as a gem or write something by hand. I'm thinking the former. – Allow the user to write the post right there in the command line and not have to open a text editor. – Allow the user to choose which text editor to use at the prompt (perhaps with detection?)

It's a good first draft and it serves the purpose I had in mind. Here's the GitHub repo.

