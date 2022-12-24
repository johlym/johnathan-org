---
title: Upload a WeeWX-Generated Site to Heroku or Netlify
slug: upload-weewx-generated-site-to-heroku-or-netlify
description: For the weather nerds, WeeWX is arguably the defacto weather Web site generator. Here's how to upload the generated content to Heroku and Netlify.
author: null
date: 2022-12-23T12:33:00:000Z
last_modified_at: 2022-12-23T12:33:00:000Z
draft: true
category: programming
---

I'm a bit of a weather nerd. More specifically, I'm a bit of a [weather data collection nerd](https://leahillwx.org). I've had a weather station set up at my home to track temperature, humidity, wind speed, and rain quantity. From those metrics additional data like wind chill and dew point are also tracked using some math.

## The Data Flow

The weather station is an Ambient Weather WS-2902C. It transmits its measurements using the 915MHz (US Industrial & Manufacturing) frequency band to a small device in my kitchen, the GW-1100. _That_ device, is connected to my WiFi and broadcasts UDP packets on my IOT network.

WeeWx listens for those packets and consums them, tossing the data within into the attached MySQL database. The GW-1100 broadcasts a packet every 10 seconds as it receives new measurements from The WS-2902C weather station. Additionally, it sends the data packet to an MQTT broker which allows for the final render of the site to update at 5-second intervals.

Outside of the MQTT implementation, the HTML is generated every minute with the most current information, along with relevant historical data points for various charts and tables.

## The Default Option for External Hosting

One thing I both love and hate about WeeWX is that it's straight out of 2003, even though the project [started in 2008](https://weewx.com/docs/usersguide.htm#about) or so. Configuration is done through one massive `weewx.conf` file, and while it remains maintained, the way it works and The Way It Is™ hasn't progressed a day. This means we're left with less user-friendly means of deploying the generated HTML site somewhere that makes sense.

The recommended method is to use rsync. Most with any sort of Linux background will understand why that's an option, but it feels like we can do _much_ better in 2022, right?

Before working through this project, I had the site hosted on a Linode VM. Nginx was configured as one would configure it for serving static content, and that's that. Thing is, I'm already managing a Linux instance in running WeeWX, and I'm not about to simply hook that instance up to the Internet. Too simple.[^1]

**Disclaimer:** I'm not sure my alternatives are actually any better, just different. My goal was to use modern platforms to host the site, is all.

### Sending Everything Through Git & GitHub

The first thing I started thinking about is how I'd normally get a site deployed on Heroku or Netlify. My mind went straight to Git and triggering on merges through a GitHub connection. It seems easy enough.

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

It felt benign, and every 5 minutes also felt _good enough_. After someone loads the site, the MQTT stream will update any relevant values, anyway, and that happens quick enough.

Here's where things start to get spicy. Every add+commit+push dumps roughly 14 files chaned with about 800 additions and 450 deletions. As I write this, it's been a bit less than 24 hours since I started this ~GitHub stats padding~ project and, well...

```
18 changed files with 195,679 additions and 194,199 deletions.
```

Hahahaha... 

Shit.

Where's all that coming from? Minute-by-minute updates of all the JSON objects for the hourly, daily, weekly, monthly, and yearly stats histories, potential changes to every value on every HTML page, and updating the NOAA records. Since all of the temperatures have a precision of 1/10th of a degree, that means even more potential changes of values, even if they're minute.

### APIs and Direct Uploads

## Deploying the WeeWX site to Heroku

## Deploying the WeeWX site to Netlify

---

[^1]: I could have skipped the rsync process and used something like Tailscale to hook up a small Linux VM on Linode to the WeeWX instance. I might revisit that idea in the future for completeness' sake.