---
title: "Fixing 'ArgumentError: Invalid Domain' After Upgrading to Ruby 2.7.7"
slug: ruby-2-7-7-invalid-domain
description: null
author: null
date: 2022-12-19T12:33:00:000Z
last_modified_at: 2022-12-19T12:33:00:000Z
draft: false
category: programming
---

Recently I tasked myself with upgrading one of the apps I support as a part of my day job from Ruby version 2.7.6 to 2.7.7.

After doing so, I immediately started running into this issue, only while running tests, and only when those tests were run in CI:

```
ArgumentError:
       invalid domain: ".example.com"
```

Strange. None of the other apps I upgraded had this issue, and I'm not setting anything domain-specific like this in my app code, so the first thing I thought to do was go back to 2.7.6 to make sure I didn't jack something up. Of course it worked fine so there had to be something special about this upgrade that was causing issues.

Skipping the part where `RAILS_ENV=test` && `CI=true` were really just a red herring, the head-desk-ing that took place therein, and knowing that the version bump was primarily due to [CVE-2021-33621](https://www.ruby-lang.org/en/news/2022/11/22/http-response-splitting-in-cgi-cve-2021-33621/) caused by the `cgi` rubygem, I had what felt like an entirely random thought[^1] to check the `cgi` rubygem itself for this message.

Sure enough, it's there, [plain as day](https://github.com/ruby/cgi/blob/master/lib/cgi/cookie.rb#L128)[^2].

Feeling like I was on a roll, my next thought was to check any open issues for that rubygem. I can't imagine I'm the first to run into this, right?

[Definitely not](https://github.com/ruby/cgi/issues/35) (tangentially, [this](https://github.com/ruby/cgi/pull/29) PR). Turns out™, in the course of updating `cgi`, cookie logic was changed to disallow cookies with preceding periods, because who does that, anymore? 

I guess I do. 🤷🏼‍♂️

**Ok, so what's the fix?** Well, on its own, Ruby 2.7.7 still holds the version of `cgi` that disallows cookie domains with leading periods, so you've got two options:

1. Stop using leading periods for your cookie domains
2. Upgrade `cgi` by explicitly defining it in your `Gemfile` with `gem 'cgi', '~> 0.3.6'`

On the face of it, doing the more currently-appropriate thing is probably the right move, but I didn't have a ton of time to make those changes and ensure nothing broke, so I took the second option. I'll probably come back to this and do it the better[^3] way in the future. 

Or not. If Ruby `2.7.next` (and equivalent `3.x.next` branches) pick up `cgi` 0.3.6 or a later version, I may never. 

---

[^1]: I was on my last day before taking the rest of my parental leave, so I was willing to take a W from wherever I could, at this point.
[^2]: entirely subjectively plain as day.
[^3]: better insomuch as that depending on [who you ask](https://github.com/ruby/cgi/pull/29#issuecomment-1325852303) and [how you interpret it](https://github.com/ruby/cgi/pull/29#issuecomment-1328487556), RFC 6265 says both [yay](https://www.rfc-editor.org/rfc/rfc6265#section-5.2.3) and [nay](https://www.rfc-editor.org/rfc/rfc6265#section-4.1.1), but it was once entirely acceptable in in [RFC 2109](https://datatracker.ietf.org/doc/html/rfc2109#section-4.2.2).