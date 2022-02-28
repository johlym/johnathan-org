---
title: Fixing Browsersync Not Reloading
featured: false
layout: post
date: 2017-12-08 02:52:00 -08:00
last_modified_at: 2022-02-28T23:14:57.880Z
tagged: programming
---

I wanted to jot this down real quick while I work on the next version of this site. I'm using [Gulp](https://gulpjs.com) and [Browsersync](https://browsersync.io) and for the life of me I couldn't get the reload to actually take place. Turns out I didn't specify properly what files Browsersync needs to trigger when changed. Here's the `gulp.task()` that worked for me:

```js
gulp.task('browsersync', function (callback) {  
  browserSync.init({
    proxy: 'localhost:2368',
    files: ['app/ **/*.hbs', 'app/assets/scss/** /*.scss']
    
  });

  callback();
});
```

Note the `files:` array added to the `browserSync.init()` function. That's the ticket, right there. Once I did that, it was magic sauce all over again.

