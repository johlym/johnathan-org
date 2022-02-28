---
title: Doubling Down on DNS Records
featured: false
layout: post
date: 2017-12-20 00:31:16 -08:00
last_modified_at: 2022-02-28T23:15:43.810Z
tagged: programming
---

 **September 2018:** I have since moved away from this and use ~Cloudflare~ Dnsimple exclusively. 

It might seem like a pretty silly thing to most but doubling up on DNS records (having a domain name point to two complete sets of name servers from two different DNS providers) is a wise and relatively easy way to add a touch of redundancy to your web properties.

For instance: in February 2017, Amazon AWS took a huge crap and a lot of their services were partially or completely down. One of those services was Route 53. For sites that relied on Route 53 exclusively, folks might not have been able to reach them. If those sites had a second DNS provider, traffic would flow exclusively through them as this second provider would be the only up and available source of DNS information.

Making this happen is pretty easy. The hardest parts are either a) having a registrar that lets you have more than 4ish name server records and b) finding two DNS services that support [AXFR](https://en.wikipedia.org/wiki/DNS_zone_transfer).

In my case, I use [DNSimple](https://dnsimple.com) as my primary DNS provider and [NS1](https://ns1.com) as my backup. Since DNSimple is my primary, it's considered the authority in this exchange so NS1 is regularly checking in to DNSimple and keeping the records updated that way. If DNSimple was to fall over, NS1 would still be available to respond to requests and visitors would still make it here. My domain registrar, [Hover](https://hover.com/mZdZcsHw), allows for at least eight name server entries. They'd probably go higher, but I haven't checked; DNSimple and NS1 only provide 4 name servers each.

## Making it happen

The first step in my process is setting up the domain with DNSimple and configuring it for Secondary DNS.

Once that's done, I create a new **secondary** zone with NS1, feeding it the special AXFR IP from DNSimple.

## What about three?

I mean, I guess if you wanted. One thing to be careful of is making sure each provider is consistently up to date. It can take a few hours to a day for DNS records to fully propagate across the Internet.

## Cost

DNSimple's plans start at $5/month for 5 domains. Every one thereafter is $0.50/month. That's stupid cheap. NS1 has a free tier and their plans are based on the number of DNS queries a domain receives and the total number of records rather than zones (domains). The free tier allots 500k queries and 50 records. That means if someone had 25 domains with two records (non-www, and www), they could in theory pay nothing for the service, whereas it'd cost $15/month with DNSimple.

If I wanted, I could _really_ make this cheap by using [Cloudflare](https://cloudflare.com) just for DNS in place of DNSimple, but it's not enough of a savings to really matter, in my opinion.

Either way, DNS management is cheap for folks like myself that run a small blog and if you're playing with the right toys, it's easy and well worth it to have DNS redundancy for your sites.

