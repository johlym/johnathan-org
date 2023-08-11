---
title: Prevent ChatGPT from Scraping Your SIte
slug: no-gpt-scrapey-scrapey
description: The goods you need to add to robots.txt to keep ChatGPT from consuming your work.
author: null
date: 2023-08-11T16:00:00:000Z
last_modified_at: 2023-08-11T16:00:00:000Z
draft: false
category: programming
---

<!-- @format -->

A short but sweet post. Ready?

OpenAI quietly published the crawler name/user agent for ChatGPT, creatively named GPTBot.

Since we know the user agent, now, we can effectively prevent it from crawling a site using `robots.txt` like so:

```
User-agent: GPTBot
Disallow: /
```

### IP Ranges

OpenAI was also generous enough to provide [a list of IP ranges](https://openai.com/gptbot-ranges.txt) their crawler will connect from, so go ahead and add these to your firewall rules, too:

```
20.15.240.64/28
20.15.240.80/28
20.15.240.96/28
20.15.240.176/28
20.15.241.0/28
20.15.242.128/28
20.15.242.144/28
20.15.242.192/28
40.83.2.64/28
```
