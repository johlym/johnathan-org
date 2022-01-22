---
title: Fixing Browsersync Not Reloading
slug: fixing-browsersync-not-reloading
featured: false


layout: post
categories: posts
date: 2017-12-08 02:52:00.000000000 -08:00
---

I wanted to jot this down real quick while I work on the next version of this site. I'm using [Gulp](https://gulpjs.com) and [Browsersync](https://browsersync.io) and for the life of me I couldn't get the reload to actually take place. Turns out I didn't specify properly what files Browsersync needs to trigger when changed. Here's the `gulp.task()` that worked for me:

```
gulp.task('browsersync', function (callback) {  
  browserSync.init({
    proxy: 'localhost:2368',
    files: ['app/ **/*.hbs', 'app/assets/scss/** /*.scss']
    
  });

  callback();
});
```

Note the `files:` array added to the `browserSync.init()` function. That's the ticket, right there. Once I did that, it was magic sauce all over again.

