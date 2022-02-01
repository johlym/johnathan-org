---
title: 'Fake SSL: Another Reason to Own a Mac'
slug: fake-ssl-another-reason-to-own-a-mac
featured: false


layout: post
categories: posts
date: 2015-02-21 09:09:39.000000000 -08:00
---

I'm almost positive I'll receive flack for this from people who think I'm talking out my @$$, and that's fine. Recently, it has come to light that certain model Lenovo laptops were shipping with what most would chalk up to nothing more than adware, a.k.a Superfish. For a few months at the end of 2014, consumer grade Lenovo laptops received this software that hijacks web browsing sessions ([HTTPS](http://en.wikipedia.org/wiki/HTTP_Secure) included) and injecting them with ads it feels you'll appreciate.

By that description, about every adware out there is on the same level, and probably is viewed all the same by Lenovo. Curious enough, this software wasn't ever present on any business-class laptop or desktop like the ThinkPad or X1.

This type of attack is what's referred to as a MITM or a [Man-in-the-Middle](http://en.wikipedia.org/wiki/Man-in-the-middle_attack) attack. It sits quietly between you and whatever your destination is on the web and picks out and replaces bits as it sees fit. In this case, these bits were ads. Typically this isn't easily done, if at all, with secured traffic (identified with `https://` in the address) but Superfish took it one step further, and packaged their adware with an additional root certificate that masquerades as being owned by whichever secure site you visit. A typical user probably wouldn't ever notice this as their browser would show the site is secure and the certificate is for said site. A few seconds of clicking around would reveal that certificate isn't actually owned by the site (or company) being visited, exposing the catastrophic problem.

What makes this even worse is Lenovo claims they though their users would [enjoy it](http://arstechnica.com/security/2015/02/lenovo-honestly-thought-youd-enjoy-that-superfish-https-spyware/). I don't have much else to say surrounding that. It seems pretty self-explanatory that Lenovo's consumer division is an idiot.

Some more technically inclined people would catch on to this right away and make the necessary changes to pull the root CA and be on their merry way. Others would wipe their system and install Windows fresh from the get-go without any of the bloatware or extra crap to this day still ships on some consumer PCs.

_ **Pro Tip** : If you want a retail machine that doesn't ship with s–t, buy a business desktop or laptop. You'll have a much better time._

If you're interested in knowing more about wiping your PC the easy way or cleaning it up without all the hassle, Paul Thurrott has [great articles on his site](https://www.thurrott.com/tag/clean-pc) for doing that.

If you're more adventurous, you could wipe the root CA away yourself with some help from [this article](http://arstechnica.com/security/2015/02/how-to-remove-the-superfish-malware-what-lenovo-doesnt-tell-you/) by Ars Technica.

Windows Defender has new functionality to clean out this adware, as highlighted by Microsoft, so [running it might also solve your problems](http://arstechnica.com/security/2015/02/windows-defender-now-removes-superfish-malware-if-youre-lucky/), if you're one of the few users running one of these systems.

But let's talk about my original statement in the title of this post. This wouldn't have ever happened on a Mac. I know I say crap like that all the time, and while it's true, I understand how it can sound douchey. Too bad I don't care. One of the many reasons I bought a mac was for security. I know that computers are inherently safer if people aren't attacking them but with the market share in the [double digits](http://techcrunch.com/2014/11/07/mac-achieves-highest-u-s-pc-market-share-ever-in-q3-2014-according-to-idc/) now, an attacker could still stand to gain a bit from Mac users.

Windows PCs have been plagued with pre-loaded crap for years. Back in the mid-2000s, they came with a literal boat load of freeware, shareware, trial software, and other adrific crap no one wanted. It was how the PCs became so cheap after a time. Today, they're still cheap, and like the above scenario, [still holding crap nobody wants](http://www.howtogeek.com/174587/refreshing-your-pc-wont-help-why-bloatware-is-still-a-problem-on-windows-8/).

Something Apple does will is keep a tight grip on the shipping product. There aren't companies stuffing their crap into Apple systems of any kind so Apple [can make an additional few dollars and random companies can do the same](http://www.howtogeek.com/163303/how-computer-manufacturers-are-paid-to-make-your-laptop-worse/). The out-of-the-box experience has always been a big deal for Apple and while us Mac users might be paying a premium, we're also being spared from massive security holes and the like created by third parties and purposely installed by our computer manufacturer.

I'm not going to try and deny fake SSL certificates can't appear on a Mac. It's possible, for sure. The key here is Apple doesn't ship with them.

Microsoft claims to be doing some good work in this area with their Signature Edition PCs you'll probably only find in Microsoft Stores. It's a bit cheesy but their site describes [how much faster your new Windows PC can be](http://www.microsoftstore.com/store?SiteID=msusa&Locale=en_US&Action=ContentTheme&pbPage=MicrosoftSignature&ThemeID=33363200) if you bought it from Microsoft instead of that cheap @$$ PC OEM. You know it's a sad day when Microsoft is taking advantage of the situations their own OEMs have created (the same ones that buy Windows OEM licenses from them) in order to make some extra cash. It's pretty much a double-dip on Microsoft's part and they're enjoying it, I'm sure.

While I write this on my Mac, let's not forget not every manufacturer does this. Be sure they're being watched even closer now by security experts who are waiting for the day the next batch of PCs comes out with vulnerability-laden crap.

Also, if you're interested: Superfish has gone silent. I guess they won't be needing those new iOS developers they're hiring for, after all.

