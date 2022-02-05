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

<!--missing_image-->

It'll ask for your password. Plug it in and hit enter.

<!--missing_image-->

Head back to **System Preferences** \> **Security and Privacy** and you should see the “Anywhere” option once more. If it used to be ticked before your upgrade to Sierra, it should be ticked again, now.

This workaround disables Gatekeeper altogether, though if you're choosing the “Anywhere” route, having it on isn't all the helpful, anyway.

