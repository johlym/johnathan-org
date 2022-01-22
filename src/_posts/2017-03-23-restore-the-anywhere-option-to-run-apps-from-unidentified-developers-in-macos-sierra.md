---
title: Restore the Anywhere Option to Run Apps from Unidentified Developers in macOS
  Sierra
slug: restore-the-anywhere-option-to-run-apps-from-unidentified-developers-in-macos-sierra
featured: false


  to bring


layout: post
categories: posts
date: 2017-03-23 15:41:36.000000000 -07:00
---

I hadn't realized until today that this setting was hidden in macOS Sierra. After a colleague pointed it out, I decided this needed fixing. Here's how to bring back the third “Anywhere” option in macOS Sierra.

From the Terminal, run:

`sudo spctl --master-disable`

![](/content/images/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-4.41.02-PM.png)

It'll ask for your password. Plug it in and hit enter.

![](/content/images/wp-content/uploads/2017/03/Screen-Shot-2017-03-23-at-4.36.15-PM.png)

Head back to **System Preferences** \> **Security and Privacy** and you should see the “Anywhere” option once more. If it used to be ticked before your upgrade to Sierra, it should be ticked again, now.

This workaround disables Gatekeeper altogether, though if you're choosing the “Anywhere” route, having it on isn't all the helpful, anyway.

