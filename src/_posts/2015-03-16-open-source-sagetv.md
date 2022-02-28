---
title: Open-Source SageTV
featured: false
layout: post
categories: posts
date: 2015-03-16 06:49:30 -07:00
last_modified_at: 2022-02-28T22:50:18.742Z
tagged: television
---

Comcast, I hope you're reading this.

>  SageTV founder (and current Google employee) Jeffrey Kardatzke says that Google “has agreed to open-source the SageTV platform.”
> [[s](http://www.engadget.com/2015/03/16/google-open-sourcing-sage-tv/?ncid=rss_truncated)]

If you're unfamiliar, SageTV has been off the market for a few years now after being one of the first to release a DVR box and home theater PC software title. Google bought it up and pulled it away, only to end up using it in their Google Fiber TV box.

It's great to see this kind of move. There's a lot of capability in set top boxes that go untouched. I can speak from experience with my X1 box from Comcast. I have HDMI in and out, of which I can only use the OUT. I also have USB and Ethernet, both of which do nothing. I would love to be able to use the ethernet jack instead. It would behoove Comcast to switch to an IPTV-type setup, instead. The bandwidth of traditional cable (QAM256) is limited to something like 39mbps per channel, and each channel is typically split in half (since there aren't enough channels in the spectrum for 1:1 usage). That brings us down to 19.8mbps per channel, at max. That's not bad, but it could be better. Blu-Ray discs are usually 25-35mbps for video and roughly 5-8mbps for audio. Compressed 5.1 is roughly 1.5mbps so taking that out of our 19.8mbps stream leaves us with 18.3mbps.

But enough about that. I can ramble about the quality of a TV signal all day. The point is that each stream could be any number of bits in size, not just a technological maximum of 19.8mbps. The trick would be switching streams in a timely manner and implementing some pretty hardcore QoS all along the pipe to ensure the TV signal doesn't become degraded because your kids are having a LAN party in their room and sucking up all the Internets.

Even without a move to IPTV, opening up a box to other apps and developers would make for a much more desirable platform, regardless of the vendor. One thing I've always wanted on my X1 was a Netflix app. Will that happen? Probably not, so long as Comcast has a beef with Netflix.

The trick will be to not let too many crazy things through the flood gates. If app developers start making shoddy apps, the quality of service for the entire system becomes compromised, and we know how Google loves to keep Android and open platform and what that ultimately does for the quality of apps.

