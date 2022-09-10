---
title: Deploying A Jekyll Static Site with Circle CI
featured: false
layout: post
date: 2018-05-31 23:41:00 -07:00
last_modified_at: 2022-02-28T23:28:56.296Z
category: programming
---

One of the primary steps in making each iteration of this site happen is deploying its generated HTML files to my Digital Ocean server. Since these are just static files and there isn't a CMS backing them up (in a traditional sense), there needs to be an automatic process that takes care of it after I make a change. If I had to manually push or build the site every time I added something, I'd:

1. never do it
2. go back to a CMS

This is where [Circle CI](https://circleci.com) enters the picture. Used mainly for software development, Circle CI allows those who are more inclined in the software development realm to build, test, and deploy code. If it can run on a Linux command line, Circle CI can run it.

For the grand starting price of zero and the promise of keeping code open source, I'm offered up to four concurrent builds and 25 hours of build time. As the operator of a static site powered by Jekyll, this is way more than I'll need, but I'm glad it's there.

# Goals

- Break down how I make this site happen with Circle CI.
- We'll take a look at my Circle CI config file and go over my workflow a bit.

It used to be way more complicated before I wrote this post but as I was thinking about what to write, I realized I was doing way more work than I needed to in the build process.

If you'd like to follow along, this entire site is available to browse through it in [GitHub repo form](https://github.com/johlym/johnathan.org) and the Circle CI config file [is here](https://github.com/johlym/johnathan.org/blob/master/.circleci/config.yml).

# Table of Contents

- [Deployment](#deployment)
  - [Pre-game Tasks](#pre-game-tasks)
  - [Cache Handling, Part 1](#cache-handling-part-1)
  - [Installations](#installations)
  - [Site building](#site-building)
  - [Site tweaking](#site-tweaking)
  - [Server Push](#server-push)
- [Post-Deployment](#post-deployment)
  - [Cloudflare](#cloudflare)
  - [Cache Handling, Part 2](#cache-handling-part-2)
- [Workflow Management](#workflow-management)
- [Wrap Up](#wrap-up)

# The Circle CI File

Starting off first, let's take a look at the defaults I have set:

```yaml
defaults: &defaults
  docker:
    - image: circleci/ruby:2.5.1-node-browsers
  working_directory: ~/repo
```

What you're looking at here are values that I'll always need, no matter how many steps, jobs, etc. I'll end up with. Since I have only one job, this is more of my “do not touch” section in that these values will never change and only new ones will be added. (You can find a more in-depth explanation of the purpose of `defaults` [here](https://circleci.com/docs/2.0/workflows/#using-workspaces-to-share-data-among-jobs).)

```yaml
version: 2
jobs:
  the_only_job:
    <<: *defaults
```

Now we're entering job territory. This is where I specify the actual tasks I need Circle CI to run. &nbsp;I only have one job, now–`the_only_job`–but if I had more, they'd be broken down like this:

```yaml
version: 2
jobs:
  the_only_job:
    <<: *defaults
  except_its_not:
    <<: *defaults
  a_third_job:
    <<: *defaults
```

Each job would call upon the defaults because Circle CI treats each job as a separate build and would need its own container. In multi-job scenarios, having a set of defaults to share across all jobs is truly a no-brainer.

## Deployment

Inside our job, we have a set of `steps:`.

**Note:** This is a list of tasks that should be performed by the container. &nbsp;Everything in this section is in the context of:

```yaml
jobs:
  the_only_job:
    <<: *defaults
    steps:
```

So never mind the lack of full indentation. It saves me from repeating lines a dozen times.

### Pre-game Tasks

```yaml
- add_ssh_keys:
    fingerprints:
      - "69:fe:2c:df:c8:34:c5:e6:3f:6e:18:64:43:97:58:02"
```

The very first thing I have the container do is add an SSH key using the `add_ssh_keys` step. I've provided Circle CI with a key to the production server as a specific deploy-only user. &nbsp;This adds the key to the container so it can connect to the server later without me needing to provide hardcoded credentials. Doing so would be a massive security breach as my Circle CI builds are open to the public.

```yaml
- checkout
```

Once that's good to go, I have Circle CI checkout the latest code from the `master` branch of `johlym/johnathan.org`. Simple enough.

```yaml
- attach_workspace:
    at: ~/repo
```

The third step is `attach_workspace`. This was more relevant when I had multiple jobs but the idea here is that we're creating a persistent and consistent location within the job container to do all our task work. In this case, I need to make it clear that we'll be doing all our work in `~/repo` from here on out.

### Cache Handling, Part 1

```yaml
- restore_cache:
    keys:
      - v1-bundle-{% raw %}{{ checksum "Gemfile.lock" }}{% endraw %}-{% raw %}{{ checksum "package.json" }}{% endraw %}
```

This part is important if there's even a stretch goal of having a speedy build process. &nbsp;The `restore_cache` step looks for a cache file that we've already built (something we'll do at the end) to save time with things like `bundle` and `npm`. Without this, we could spend a few minutes just installing Rubygems and Node modules. bleh.

The cache file uses MD5 hashes of the `Gemfile.lock` and `package.json` files combined. If those files never change, the MD5s won't either, so this cache will remain valid. If I were to update a gem, for example, the cache would be invalid and Rubygems and Node modules would be installed.

One potential spot for improvement here is to break this out into two separate caches, but Circle CI doesn't handle that well, so this'll be fine.

### Installations

```yaml
- run: 
    name: Install Rubygems if necessary
    command: |
      bundle install --path vendor/bundle --jobs 4 --retry 3
- run: 
    name: Install Node modules if necessary 
    command: |
      cd ~/repo && npm install
- run: 
    name: Install Rsync
    command: |
      sudo apt install rsync
```

This part is pretty straight forward. I need to make sure all the required Rubygems, Node modules, and Rsync are installed. In this case, I'm making sure `bundle` puts everything in `vendor/bundle` (remember, this is relative to `~/repo` since we declared that to be our workspace earlier) when it installs. The Node modules I don't need to worry so much about. The `package.json` would be located in the `~/repo` directory since that's where the code was checked out to so we hop in there and get to it. &nbsp;It'll plop its `node_modules` file at `~/repo/node_modules` as a result. This is totally acceptable. Lastly, we install `rsync` via `apt`. Nothing special.

### Site building

```yaml
- run: 
    name: Build site
    command: |
      bundle exec jekyll build --profile --verbose --destination /home/circleci/repo/_site
```

For those who've worked with Jekyll before, this command shouldn't come as a surprise. We're asking Jekyll to build out the site and place it at `~/repo/_site`. The `--profile` and `--verbose` flags are for CI output, only, in case there's an error or my curiosity gets the better of me.

### Site tweaking

```yaml
- run:
    name: Install and run Gulp
    command: |
      cd ~/repo && npx gulp
```

When considering how I wanted to handle minification of HTML and JavaScript, I considered the `jekyll-assets` plugin, but decided against it because of the amount of overhead and work that would be required to implement it in my already moderately-sized site. &nbsp;This is where I decided to bring in Gulp, instead. I have a simple Gulpfile that's set up to use a couple Gulp modules to minify all the HTML and local JavaScript. Over the 400-something pages I have, this saves me about 20% on the site size overall. &nbsp;Not too shabby.

You'll notice we need to use [`npx`](https://github.com/zkat/npx) here. For some reason, I was never able to get Gulp to run on its own… it would look for the `gulp` binary in strange places I could not control. `npx` allows me to run `gulp` wherever, so long as it can find the corresponding `node_modules` folder for reference. Brilliant, eh? Portable Gulp.

### Server Push

```yaml
- run: 
    name: Deploy to prod server if triggered via master branch change
    command: |
      if [$CIRCLE_BRANCH = 'master']; then rsync -e "ssh -o StrictHostKeyChecking=no" -va --delete ~/repo/_site deploy@159.65.70.80:/var/www/johnathan.org/static; fi
```

This is pretty straight forward, as well, though it can look complicated to the untrained eye. What we're doing is here is first checking if the branch this build is based off of is the `master` branch. We'll find that value in the `CIRCLE_BRANCH` ENV variable. If it is not, we'll skip this, but if it _is_, we'll run `rsync` to push the contents of `~/repo/site` over to the production Digital Ocean server. I'm using the IP here because of [Cloudflare](https://cloudflare.com), though I have a TODO item to use a hostname instead.

## Post-Deployment

For all intents and purposes, the deployment is done, but because of Cloudflare, we have one additional step to make sure everyone's seeing the freshest code.

### Cloudflare

(we're still in the `jobs` context)

```yaml
- run: 
    name: Bust Cloudflare cache if triggered via master branch change
    command: |
      if [$CIRCLE_BRANCH = 'master']; then 
        curl -X POST "https://api.cloudflare.com/client/v4/zones/$CLOUDFLARE_ZONE_ID/purge_cache" \
        -H "X-Auth-Email: $CLOUDFLARE_API_EMAIL" \
        -H "X-Auth-Key: $CLOUDFLARE_API_KEY" \
        -H "Content-Type: application/json" \
        --data '{"purge_everything":true}';
```

Using [the Cloudflare API](https://api.cloudflare.com), we're submitting a `POST` request to dump the entire cache for the `johnathan.org` DNS zone. I've provided Circle CI with the necessary information as ENV variables and am calling upon them here. This keeps them safe and the job step functional.

I wouldn't recommend this for high-volume sites, but because I have Cloudflare caching just about everything combined with the fact that I maybe do this a couple times a week, this feels like the right level of effort and precision.

### Cache Handling, Part 2

```yaml
- save_cache:
    key: v1-bundle-{% raw %}{{ checksum "Gemfile.lock" }}{% endraw %}-{% raw %}{{ checksum "package.json" }}{% endraw %}
    paths:
      - ~/repo/vendor/bundle
      - ~/repo/node_modules
```

Earlier, we called upon the generated cache. Here is where we create it if necessary. This'll do the same check step before acting. If the cache file already exists with the same MD5s, we'll skip creating it, but if it's missing, we'll build it out, making sure to capture everything from the `~/repo/vendor/bundle` and `~/repo/node_modules` folders we referenced with Rubygems and NPM.

## Workflow Management

```yaml
workflows:
  version: 2
  build_site:
    jobs:
      - the_only_job
```

I used to have multiple jobs running in a breakout-combine pattern, and this is leftover from that. Although I only have one job, now, I didn't want to re-craft it to not use Workflows, so I just operate with a one-job Workflow instead. XD

# Wrap Up

That about does it for my overview. This process is turning out to work very well for me and I'm glad I took the time to both develop it and explain it for posterity. Over time, it'll morph, I'm sure, but right now this feels like a really good bass to work off of.

Thanks for taking the time to read this. Cheers!

