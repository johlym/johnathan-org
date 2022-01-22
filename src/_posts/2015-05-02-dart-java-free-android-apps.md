---
title: 'Dart: Java-Free Android Apps'
slug: dart-java-free-android-apps
featured: false


layout: post
categories: posts
date: 2015-05-02 19:22:26.000000000 -07:00
---

Made by some folks from the Chrome V8 Javascript engine team, Dart tries to solve 20-year old frustrations of working with Java. A language created completely in house, it feels a lot like Python.

from ArsTechnica:

> Being fast and responsive is one of the biggest goals for Sky. While 60FPS (or Hz) is the smoothness standard most devices and app developers aim for, the Dart team wants to crank that up to 120FPS, which isn't even possible to display on the standard 60Hz smartphone screens we have today. That sounds rather improbable on Android, where many apps don't stay at 60FPS, let alone 120. Rendering an app at 60FPS requires a frame to be drawn every 16ms, and apps “jank” or display an animation stutter, when they can't keep up with the 16ms deadline.

I know the feeling. I've experienced it myself many times when I used to own an Android device. I also am a fan of the word “jank.”

> The Dart team brought along a demo app, and it was rendering entire frames in 1.2ms. While it was a simple example, it appears Sky has plenty of headroom for silky-smooth animation on more complicated apps and makes that 120FPS goal (8ms rendering time) seem like a possibility. The Dart team says Sky is “Jank-free by design” with APIs that don't block the main UI thread, meaning that even if the app slows down, the UI will still be fast and responsive.

Now that's what I'm talking about. I'm not entirely sure why 120fps is necessary as they're still struggling to get 60fps to run smooth. Baby steps, folks. Sure there's nothing wrong with aiming high, but I'd hate to see this dropped because they never got to 120fps in real world use cases.

Read the rest of the article [Dart on ArsTechnica](http://arstechnica.com/gadgets/2015/05/01/googles-dart-language-on-android-aims-for-java-free-120-fps-apps/) or [check out Dart](http://dartlang.org) for yourself.

