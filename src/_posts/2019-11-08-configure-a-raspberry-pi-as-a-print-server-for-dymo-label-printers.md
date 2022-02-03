---
title: Configure a Raspberry Pi as a print server for Dymo label printers
slug: configure-a-raspberry-pi-as-a-print-server-for-dymo-label-printers
featured: false

layout: post
categories: posts
date: 2019-11-08 17:01:06.000000000 -08:00
---

This seemed like an odd article to post after nearly 11 months of blog inactivity, but it's a problem I had to solve on my own today and felt it necessary to write this. Other Internet-based sources I consulted ended up only being partially correct so this is ultimately a combination of all the correct pieces of information that exist online.

I'm going to assume you have a Raspberry Pi (I'm using the Pi 3B+) already set up and connected to your network.

**Parts:**

1. [Install and configure CUPS](#part1)
2. [Install Dymo printer drivers](#part2)
3. [Add the Dymo printer to CUPS](#part3)

## Part 1: Install and configure CUPS

This is relatively easy and only requires a few steps.

1. Ensure your package repository information is up to date, then download and install cups:

```
sudo apt-get update
sudo apt-get install cups
```

2. Once installed, open `/etc/cups/cupsd.conf` and make the following changes:

…change the listen configuration to listen globally on port 631…

```
# Only listen for connections from the local machine.
Port 631
```

…and update the `<Location>` configurations to allow local user access…

```
<Location />
# Restrict access to the server...
Order allow,deny
Allow @local
</Location>

<Location /admin>
# Restrict access to the admin pages...
Order allow,deny
Allow @local
</Location>

<Location /admin/conf>
AuthType Default
Require user @SYSTEM

# Restrict access to the configuration files...
Order allow,deny
Allow @local
</Location>
```

3. Add your Pi's user to the `lpadmin` user group:

```
sudo usermod -a -G lpadmin pi
```

(there are alternative ways to handle this, like change which user group CUPS should consider properly allowed to make printer changes, but in all likelihood, this'll be sufficient.)

4. Restart CUPS

```
sudo service cups restart
```

## Part 2: Install Dymo Printer Drivers

This is the part where I got stuck. Most documentation will point you to the official download, but during the install process, I received tons of errors and had to back out of it.

### Preferred method

1. Install the `printer-drivers-dymo` package:

```
sudo apt-get install printer-driver-dymo
```

### Alternative method

Alternatively, you can follow the below steps to download and compile manually, but I couldn't get this to work properly. YMMV.

1. Download the linux drivers [from dymo](https://www.dymo.com/en-US/dymo-label-sdk-cups-linux-p?storeId=20051&catalogId=10551) onto your Pi.

2. Decompress them with `tar` and enter the directory:

```
tar -zxf dymo-cups-drivers-1.4.0.tar.gz
cd dymo-cups-drivers-1.4.0.5
```

3. Configure and install the drivers:

```
sudo ./configure
sudo make
sudo make install
```

**NOTE:** During the `./configure` step, if you receive this error:

```
configure: error: Can't find cups library
```

…you'll need to point the configure script to the location of the CUPS server folder, as it was unable to find it on its own. If you installed CUPS via `apt`, it's probably at `/usr/lib/cups` so re-run the command like so:

```
sudo cups_serverbindir='/usr/lib/cups' ./configure
```

If it _still_ doesn't work, you're missing a couple fundamental libraries. Go ahead and install those:

```
sudo apt-get install libcups2-dev libcupsimage2-dev
```

## Part 3: Add the Dymo printer to CUPS

With CUPS set up and your printer (hopefully) already plugged in–if not, make that happen–access the CUPS admin interface at:

```
https://localhost:631/admin
```

Your browser will probably complain about the SSL certificate. Skip through that, if necessary. You'll land on a page that looks something like this:

{% cloudinary_img "Alt text goes here", "Screen-Shot-2019-11-08-at-4.44.20-PM-1024x715", "large" %}

1. Click the **Add Printer** button under the _Printers_ section. Select the Dymo printer and click **Continue**.

{% cloudinary_img "Alt text goes here", "Screen-Shot-2019-11-08-at-4.45.34-PM-1024x715", "large" %}

2. Fill in the fields as you see fit and make sure to check **Share This Printer** before clicking **Continue** :

{% cloudinary_img "Alt text goes here", "Screen-Shot-2019-11-08-at-4.48.03-PM-1024x715", "large" %}

If everything went according to plan in Part 2, the relevant drivers should appear, with the specific printer at the top of the list.

{% cloudinary_img "Alt text goes here", "Screen-Shot-2019-11-08-at-4.49.05-PM-1024x715", "large" %}

If that's the case, leave everything as is and click **Add Printer**.

Lastly, and optionally, set some default print settings and wrap up the setup by clicking **Set Default Options** :

{% cloudinary_img "Alt text goes here", "Screen-Shot-2019-11-08-at-4.50.12-PM-1024x715", "large" %}

The printer should be set and ready to go, and visible from the CUPS admin page:

{% cloudinary_img "Alt text goes here", "Screen-Shot-2019-11-08-at-4.51.09-PM-1024x715", "large" %}

### Conclusion

After doing this for the third time now I've found myself having to hack through some component of the printer driver process, save for this most recent effort (what I've documented in this post). I highly recommend doing everything via the package manager if you can help it. What made me think to include that as an option was noticing [the version of](https://launchpad.net/ubuntu/+source/dymo-cups-drivers/1.4.0-8)`dymo-cups-drivers` in the Ubuntu source repo was newer than what Dymo itself was offering. That version was also used to build `printer-driver-dymo`. When the metaphorical lightbulb came on, I realized this was probably a solution to my compile struggles.

