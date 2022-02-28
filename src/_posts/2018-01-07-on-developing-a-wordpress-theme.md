---
title: On Developing a WordPress Theme
featured: false
layout: post

date: 2018-01-07 21:07:19 -08:00
last_modified_at: 2022-02-28T22:57:04.966Z
---

A few weeks ago I started the process of moving this blog over to WordPress from Ghost—and I talked about why I did that in a previous post—so now that I've made the change, the next natural step felt like talking about how I developed a theme for the first time.

Yep, I've never done this before, and it turned out pretty well… I think.

## Local Environment

In my opinion, maintaining a proper working development environment is one of the hardest things to do. Over time it can experience something I like to call “dev rot.” To make this as easy as possible, I invoked the assistance from a tool by the great folks over at Flywheel called Local. Local does one thing: let you build, maintain, and tear down WordPress development environments on a whim. It runs a Virtualbox-powered VM under the hood and if you use the Flywheel managed WordPress hosting service, allows you to push your development environment straight up to them for one-click production pushes. It's a fantastic tool and keeps things super clean.

{% cloudinary_img, "flywheel_local-squashed", "standard" %}

## Structure

One thing I tried to figure out while I was developing was how I wanted to structure all the code. I came up with this rough directory structure. Some of these folders are unique to my current theme, but the general idea is pretty clear:

```
theme
├── app
│   ├── assets
│   │   ├── css
│   │   │   └── maps
│   │   ├── fonts
│   │   ├── images
│   │   ├── js
│   │   │   └── fa
│   │   ├── scss
│   │   │   ├── animations
│   │   │   ├── base
│   │   │   ├── layout
│   │   │   └── module
│   │   └── svg
│   └── js
├── gulp
│   └── tasks
└── johnathan-org
└── assets
├── css
│   └── maps
├── fonts
├── images
├── js
│   └── fa
└── svg
```

within the `theme` directory, `app` houses the code, `gulp` are where my automation tasks reside, and `johnathan-org` is my distribution directory. This would be unique to the theme name. The `app` name is a carryover from when I developed the theme for Ghost. In fact, a lot of this code was carried over and reused at least partially if not completely as is. The `css` directory is generated when `gulp watch` is run, something I'll cover in a bit.

## Automation Tasks

This was the hardest part of developing because I had never used any kind of serious development tools for assembling a front-end design of any kind. I discovered Gulp and all the things it can do and was instantly hooked. Here's the part where I talk about all of my gulp files.

### Gulp

My base `gulpfile.js` only contains a couple lines of code:

```js
// /gulpfile.js
var requireDir = require('require-dir');

// Require all tasks in gulp/tasks, including subfolders
requireDir('./gulp/tasks', {recurse: true});
```

The first being bringing in `require-dir` in order to do the second thing, suck in all the tasks in the `gulp/tasks` directory. Within this directory, I have two main tasks: `gulp watch` and `gulp dist`. `gulp watch` triggers a few different sub tasks:

```js
// gulp/tasks/watch.js

var gulp = require('gulp');
var runSequence = require('run-sequence');

gulp.task('watch', function (callback) {
runSequence(
'sass:compile',
'copy:dev',
'browsersync:production',
() => {
gulp.watch('app/**/*.php', () => {
runSequence(
'copy:dev',
'browsersync:reload'
);
});
gulp.watch('app/assets/scss/**/*.scss', () => {
runSequence(
'sass:compile',
'copy:dev',
'browsersync:reload'
);
});
gulp.watch('app/assets/js/**/*.js', () => {
runSequence(
'copy:dev',
'browsersync:reload'
);
});
return callback;
}
);
});
```

```js
// gulp/tasks/dist.js

var gulp = require('gulp');
var runSequence = require('run-sequence');

gulp.task('dist', function (callback) {
runSequence(
'delete',
'copy',
'sass:compile',
[
'optimize:css',
'optimize:js',
'optimize:images'
],
'zip',
'vrev',
callback
);
});
```

It probably goes without saying that these tasks aren't probably the most efficient or there's a better way to do all that I'm doing, but the fun thing about developing anything: there's more than way to do everything.

Here are those individual task files:

```js
// browsersync.js

var gulp = require('gulp');
var browserSync = require('browser-sync').create();
var proxy = 'johnathan-org-staging:80';

gulp.task('browsersync:production', function (callback) {
browserSync.init({
proxy: proxy
});

callback();
});

gulp.task('browsersync:reload', function (callback) {
browserSync.reload();
callback();
});
```

```js
// copy.js
var gulp = require('gulp');
var files = ['app/**/*.php',
'app/*.txt',
'app/screenshot.png',
'app/browserconfig.xml',
'app/assets/css/**/*',
'app/assets/fonts/**/*',
'app/style.css',
'app/assets/js/*',
'app/assets/images/*',
'app/assets/svg/*'];
var base = './app';
var prodDest = './johnathan-org';
var devDest = '/Users/jlyman/Local Sites/johnathanorg-staging/app/public/wp-content/themes/johnathan-org';

gulp.task('copy', () => {
return gulp
.src(files, {base: base})
.pipe(gulp.dest(prodDest));
});

gulp.task('copy:dev', () => {
return gulp
.src(files, {base: base})
.pipe(gulp.dest(devDest));
});
```

```js
// delete.js
var gulp = require('gulp');
var del = require('del');

gulp.task('delete', () => {
del.sync('johnathan-org');
});
```

```js
// gzip.js
var gulp = require('gulp');
var gzip = require('gulp-gzip');

gulp.task('gzip', () => {
return gulp
.src('johnathan-org/assets/**/*.{css,js}')
.pipe(gzip())
.pipe(gulp.dest('johnathan-org/assets'));
});
```

```js
// optimize.js
var gulp = require('gulp');
var cssnano = require('gulp-cssnano');
var imagemin = require('gulp-imagemin');
var uglify = require('gulp-uglify');
var size = require('gulp-size');

gulp.task('optimize:css', () => {
return gulp
.src('dist/assets/css/**/*.css')
.pipe(cssnano())
.pipe(gulp.dest('johnathan-org/assets/css'))
.pipe(size({
showFiles: true
}));
});

gulp.task('optimize:images', () => {
return gulp
.src('app/assets/images/**/*.{jpg,jpeg,png,gif,svg}')
.pipe(imagemin())
.pipe(gulp.dest('johnathan-org/assets/images'))
.pipe(size({
showFiles: true
}));
});

gulp.task('optimize:js', () => {
return gulp
.src('johnathan-org/assets/js/**/*.js')
.pipe(uglify())
.pipe(gulp.dest('johnathan-org/assets/js'))
.pipe(size({
showFiles: true
}));
});
```

```js
// sass.js
var gulp = require('gulp');
var sass = require('gulp-sass');
var sourcemaps = require('gulp-sourcemaps');
var clean = require('gulp-clean');
var runSequence = require('run-sequence');

gulp.task('sass:compile', () => {
return gulp
.src('app/assets/scss/**/*.scss')
.pipe(sourcemaps.init())
.pipe(sass().on('error', sass.logError))
.pipe(sourcemaps.write('./maps'))
.pipe(gulp.dest('app/assets/css'));
});
```

I created `vrev` to be able to use `wp_enqueue_*` and be able to cite version numbers. To prevent any kind of caching locally, the implementations use PHP's `rand()` function. In production, I need to set it to the version within my root `package.json`, which is where this task comes into play.

```js
// version-rev.js
var gulp = require('gulp');
var replace = require('gulp-replace');
var fs = require('fs');
var pJson = JSON.parse(fs.readFileSync('./package.json'));
var fnFile = 'johnathan-org/functions.php';
var vString = "'" + pJson.version + "'";

gulp.task('vrev', () => {
return gulp
.src(fnFile)
.pipe(replace('rand(100000,999999)', vString))
.pipe(gulp.dest('johnathan-org'));
});
```

```js
// zip.js
var gulp = require('gulp');
var zip = require('gulp-zip');
var size = require('gulp-size');

gulp.task('zip', () => {
return gulp
.src('johnathan-org/**/*')
.pipe(zip('johnathan-org.zip'))
.pipe(gulp.dest('./'))
.pipe(size());
});
```

And that's about it!

The biggest thing I took away from this whole process was how quickly I can make changes now and be able to iterate on previous work without a huge amount of burden or overhead.

