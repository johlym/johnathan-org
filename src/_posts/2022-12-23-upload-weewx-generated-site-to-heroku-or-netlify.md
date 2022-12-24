---
title: Upload a WeeWX-Generated Site to Heroku or Netlify
slug: upload-weewx-generated-site-to-heroku-or-netlify
description: For the weather nerds, WeeWX is arguably the defacto weather Web site generator. Here's how to upload the generated content to Heroku and Netlify.
author: null
date: 2022-12-23T12:33:00:000Z
last_modified_at: 2022-12-23T12:33:00:000Z
draft: false
category: programming
---

I'm a bit of a weather nerd. More specifically, I'm a bit of a [weather data collection nerd](https://leahillwx.org). I've had a weather station set up at my home to track temperature, humidity, wind speed, and rain quantity. Additional data like wind chill and dew point are also tracked from those metrics using some math.

## The Data Flow

The weather station is an Ambient Weather WS-2902C. It transmits its measurements using the 915MHz (US Industrial & Manufacturing) frequency band to a small device in my kitchen, the GW-1100. _That_ device is connected to my WiFi and broadcasts UDP packets on my IoT network.

The GW-1100 broadcasts a packet every 10 seconds as it receives new measurements from The WS-2902C weather station. WeeWx listens for those packets and consumes them, tossing the data within into the attached MySQL database. Additionally, it sends the data packet to an MQTT broker, allowing the site's final render to update at 5-second intervals.

Outside of the MQTT implementation, the HTML is generated every minute with the most current information, along with relevant historical data points for various charts and tables.

## The Default Option for External Hosting

I both love and hate WeeWX because it's straight out of 2003, even though the project [started in 2008](https://weewx.com/docs/usersguide.htm#about) or so. Configuration is done through one massive `weewx.conf` file, and while it remains maintained, the way it works and The Way It Is™ hasn't progressed a day. This means we're left with less user-friendly means of deploying the generated HTML site somewhere that makes sense.

The recommended method is to use rsync. Most with any Linux background will understand why that's an option, but it feels like we can do _much_ better in 2022, right?

Before working through this project, I hosted the site on a Linode VM. I configured Nginx as one would configure it for serving static content, and that's that. I'm already managing a Linux instance running WeeWX, and I'm not about to hook that instance up to the Internet. Too simple.[^1]

**Disclaimer:** I'm still determining if my alternatives are any better, just different. My goal was to use modern platforms to host the site, that is all.

### Sending Everything Through Git & GitHub

I started thinking about how I'd typically get a site deployed on Heroku or Netlify. My mind went straight to Git and triggering on merges through a GitHub connection. It seems easy enough.

On My WeeWX instance, I have a cron task that looks like this:

```
*/5 * * * * cd /var/www/html/weewx/belchertown && git add . && git commit -m "Update: $(date)" && git push -u origin main && curl -fsS --retry 3 -o /dev/null https://ping.ohdear.app/...
```

Breaking this down:

* `*/5 * * * *` – Run this cron job every 5 minutes.
* `cd /var/www/html/weewx/belchertown` – Move into the output directory for the HTML site. `belchertown` is [a WeeWX theme](https://github.com/poblabs/weewx-belchertown). Great name.
* `&& git add . && git commit -m "Update: $(date)"` – Do some `git` stuff. Write the commit message using the current date
* `&& git push -u origin main` – Push it (real good).
* `&& curl -fsS --retry 3 -o /dev/null https://ping.ohdear.app/...` – Ping an endpoint for my OhDear account to ensure this job is running.

It felt benign, and every 5 minutes also felt _good enough_. After someone loads the site, the MQTT stream will update any relevant values, and that happens quickly enough.

Here's where things start to get spicy. Every add+commit+push dumps roughly 14 files changed with about 800 additions and 450 deletions. As I write this, it's been less than 24 hours since I started this ~GitHub stats padding~ project and, well...

```
18 changed files with 195,679 additions and 194,199 deletions.
```

Hahahaha... 

Shit.[^2]

Where's all that coming from? Minute-by-minute updates of all the JSON objects for the hourly, daily, weekly, monthly, and yearly stats histories, potential changes to every value on every HTML page, and updating the NOAA records. Since all of the temperatures have a precision of 1/10th of a degree, that means even more potential values changes, even if they're minute.[^3]

### APIs and Direct Uploads

So knowing that taking the Git route means we ~pad our stats to intense levels~ have a lot of Git traffic that isn't that important, I started thinking about alternative means of deploying. To hone in, I also had to think about where I'd be deploying. I'd be interested in deploying this site to two platforms that came to mind: Heroku and Netlify. 

Both platforms have means to directly deploy ([Heroku](https://devcenter.heroku.com/articles/platform-api-deploying-slugs), [Netlify](https://docs.netlify.com/site-deploys/create-deploys/#netlify-cli)) that don't involve Git. Hence, it seems reasonable to think we could figure out a way to utilize them, replacing some of our nightmare cron with API calls.

## Deploying the WeeWX site to Heroku without GitHub

**Note:** This is probably more advanced than most would want to take on. I couldn't think of a way to do this in fewer steps that didn't involve GitHub. If you're OK with the git traffic, I recommend hooking the app up to the GitHub repo and triggering deploys automatically.

Heroku's power comes from the automatic integration with GitHub and thus automatic deploys. Since we're skipping that flow, we need to create the slug manually (including the [Nginx buildpack](https://elements.heroku.com/buildpacks/heroku/heroku-buildpack-nginx)), push the slug up to Heroku via the API, and release it. Since the final product is small (the core Linux image + Nginx + some static HTML), the creation and upload process should be quick.

I cheated and deployed the site with the Nginx buildpack configured via GitHub to add the Nginx components to my slug. Once it was live, I downloaded the slug using the `api` Heroku CLI plugin:

```sh
$ heroku plugins:install api
$ wget $(heroku api /apps/app-name/slugs/$(heroku api /apps/app-name/releases | jq -r '.[-1].slug.id') | jq -r '.blob.url') -O slug.tar.gz
```

In the above, we're installing the API plugin, then using it to:

1. Get the most recent release for the app (`app-name`) I've got live
2. Extract the `slug` ID from the release
3. Extract further a signed URL for the slug
4. Dump that into `wget` and save the output as `slug.tar.gz`

All I'll need is the contents of the `bin/` folder, so I've added it to my working directory. This has the precompiled `nginx` binaries I need.[^4] 

The next step is to create a `config/nginx.conf.erb` using the example and update the `root` path to omit `/public`:

```
server {
 listen <%= ENV["PORT"] %>;
 server_name _;
 keepalive_timeout 5;
 client_max_body_size <%= ENV['NGINX_CLIENT_MAX_BODY_SIZE'] || 1 %>M;

 root /app; # <<< this is the line I'm updating
}
```

Last step is creating a `Procfile` that looks like this to start Nginx on app boot:

```
web: bin/start-nginx-solo
```

From here, I can tar it all up.

```sh
$ cp /var/www/html/weewx/belchertown /tmp/app
$ cd /tmp
$ tar czfv slug.tgz ./app
```

I've got a good slug; now I need to [upload](https://devcenter.heroku.com/articles/platform-api-reference#slug-create) it.

```sh
$ curl -X POST \
-H 'Content-Type: application/json' \
-H 'Accept: application/vnd.heroku+json; version=3' \
-d '{"process_types":{"web":"bin/start-nginx-solo"}}' \
-n https://api.heroku.com/apps/example/slugs
```

This command returns a JSON blob that includes, among other things, an ID and a URL to `PUT` the slug to:

```
{
 "blob":{
 "method": "put",
 "url": "https://s3-external-1.amazonaws.com/herokuslugs/heroku.com/v1/SLUG_ID?AWSAccessKeyId=..."
 },
 ...
 "id":"SLUG_ID"
 ...
}
```

So we do just that:

```
$ curl -X PUT \
-H "Content-Type:" \
--data-binary @slug.tgz \
"https://s3-external-1.amazonaws.com/herokuslugs/heroku.com/v1/SLUG_ID?AWSAccessKeyId=..."

```

...and release it:

```sh
$ curl -X POST \
-H "Accept: application/vnd.heroku+json; version=3" \
-H "Content-Type: application/json" \
-d '{"slug":"SLUG_ID"}' \
-n https://api.heroku.com/apps/app-name/releases
```

Wrap all of this up into a shell script and stuff it into your cron and that's that.

I wish there were fewer steps here, but the Heroku platform doesn't accept uploads or deploys via the CLI, so we have to interact with the API directly. The steps above are largely what Heroku does intelligently behind the scenes when it's pulling from GitHub—sometimes, seeing how the sausage is made warrants respect for the easy mode.

## Deploying the WeeWX site to Netlify without GitHub

Netlify's CLI makes pretty quick work of deploying without Git. Since nothing has to be explicitly built, we can run `netlify deploy` and we're done. The process mimics what happens when Netlify picks up a GitHub change: 

1. copy the files to the destination and serve them.
2. GOTO 1 

Running `netlify deploy` for the first time adds two extra steps:

1. associating the environment (`/var/www/html/weewx/belchertown`, in this case) to a site
2. setting the publish directory (`.` or the same directory we're operating in)

We'll get a couple of URLs to check our work. Once everything looks good, we can swap in `netlify deploy --prod --dir .` (the latter to skip the prompt asking for the publish directory) to push everything directly to the production environment.

This turns our cron into:

```
*/5 * * * * cd /var/www/html/weewx/belchertown && netlify deploy --prod --dir . && curl -fsS --retry 3 -o /dev/null https://ping.ohdear.app/...
```

## Wrap Up

I wrote most of this post while working on this project; I could have missed something. What it has shown me, though, is:

1. WeeWX generates _a lot_ of data and file changes over even just a short window
2. To that end, WeeWX has a lot of room for improvement in deploying to modern platforms. Not holding my breath that'll ever happen, though.
3. Having only basic RSYNC or FTP kind of sucks.[^5]

Doing the slug-making dance is less ideal for Heroku deployments, though. The GitHub integration will make quick work of deployment to Heroku _or_ Netlify. I imagine folks would _prefer_ the Netlify option, given that Heroku [no longer offers a free plan](https://blog.heroku.com/new-low-cost-plans) (in exchange for 1000 dyno hours for $5/month) but just as well, a basic VPS to host the site and upload via RSYNC would also set one back the same $5/month.

Thanks for coming with me on this journey. 

---

[^1]: I could have skipped the rsync process and used something like Tailscale to hook up a small Linux VM on Linode to the WeeWX instance. I might revisit that idea in the future for completeness' sake.
[^2]: When I implemented this, I had no idea so many changes took place during every five-minute window. The sane side of me would have held off and figured out a more sustainable solution, but then I wouldn't have this quality content.
[^3]: I can't necessarily extend the delay between git-pushes. Making the gap too wide would create a situation where the originally presentded data (before the MQTT stream took over) would be increasingly innacurate. Plus, there'd still be the copious amounts of stats write-out.
[^4]: If you're crazy enough, you could compile Nginx as the buildpack would, and skip downloading something existing to use it. Since I had a Heroku app already active in the state I wanted to replicate, I chose to steal from there, instead.
[^5]: Yeah, [seriously](https://weewx.com/docs/usersguide.htm#config_FTP). That's still a thing. It's nothing if not an obvious example of how "the way things were done way back when" the app really is.
[^6]: testf sdaf