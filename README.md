<pre><code>
      8 888888888o  8888888888',8888' 8 888888888o   8 8888888888   8 8888888888
      8 8888    `88.       ,8',8888'  8 8888    `88. 8 8888         8 8888
      8 8888     `88      ,8',8888'   8 8888     `88 8 8888         8 8888
      8 8888     ,88     ,8',8888'    8 8888     ,88 8 8888         8 8888
      8 8888.   ,88'    ,8',8888'     8 8888.   ,88' 8 888888888888 8 888888888888
      8 8888888888     ,8',8888'      8 8888888888   8 8888         8 8888
      8 8888    `88.  ,8',8888'       8 8888    `88. 8 8888         8 8888
      8 8888      88 ,8',8888'        8 8888      88 8 8888         8 8888
      8 8888    ,88',8',8888'         8 8888    ,88' 8 8888         8 8888
      8 888888888P ,8',8888888888888  8 888888888P   8 888888888888 8 888888888888

                           CLI Utilities for Backblaze (B1)

</code></pre>
___
<div style="text-align: center;"> <h1>🔥🐝 BzBee: CLI Utilities for Backblaze </h1></div>

## ⚠️ Learning-in-Progress️ ⚠️

**Disclaimer:** This project, as of April 2022, is intended to help me learn to code. My dream is that one day it will
be useful to more people than just me, but for now it's for me.

## Introduction

I am a massive fan of the company Backblaze. They are one of the few companies that has made my life noticeably better.
I've been a photographer most of my conscious life, both professionally and enthusiast-ically. In 2001 I was taking 2
megapixel stills on a Polaroid digital camera onto a Smart Media Card. Here's an example. It's not exactly blowing
anyone's socks off.

<div style="text-align: center;">
    <img height="300" alt="Grainy picture of flowers taken on a Polaroid digital camera." style="margin-left: auto; margin-right: auto" src="img/20010116-094340-4019.JPG" width="400"/>
</div>

### The Problem

That file is less than 500kB, but to be fair I think the memory card I had was only 128MB. Fast-forward to the present
day, and now I'm shooting photos and video professionally on a Nikon Z6 II in RAW and 4K (sometimes ProRes even).
Between business and pleasure my entire data footprint is about 80TB across a huge collections of hard drives and cloud
storage providers.

I'm a big fan of the 3-2-1 principle (3 copies, 2 storage mediums, 1 off-site) and I mostly comply with it. But when
you're managing the volumes of data that I am it can become impractical and prohibitively expensive. I had my library
splayed over a myriad of physical drives with a sub-par level of organisation and redundancy. How I solved that is a
story for another time but Backblaze was a huge win in my battle to achieve 3-2-1.

### Backblaze Unlimited Backup

The Backblaze Unlimited Backup product sounds way too good to be true. In some ways it is, it's not without its quirks
and struggles but it's honestly one of the best products I use. The pricing is the same
($7/month for 1-year version history at the time of writing) whether you have 100GB or 100TB. The business model is
generous, I believe any user with over 5TB of data actively loses them money. So, as a Backblaze user with 60TB (heavily
duplicated, mind you) data backed up on Backblaze, I'm among the top 1% of the worst offenders. But the Co-founder Brian
Wilson has said while customers like me lose them money, we also push their software to the limits, so I guess I'm doing
them a favour???

### Backblaze Client Design

> TODO: Add more detail about the Backblaze Client Design

[//]: # (TODO: Add more detail RE: Backblaze client design)

If you use the Backblaze GUI you don't really understand much about what's going on, and I believe that is mostly by
design. At the end of the day, they want their backup product to be totally invisible to the end-user. But under the
hood the client is very transparent about what it's doing. If you comb through the logs you can find your entire backup
history as well as detailed logs of what Backblaze has done for the last 30 days. On top of that, the r/Backblaze
community on Reddit is very active and maintained by a few dedicated Backblaze staff members, most notably the CTO and
Co-founder of Backblaze Brian Wilson. It's pretty amazing community management to say the least.

He frequently comments on questions regarding the client (he designed it after all) and also links to many resources,
including an internal presentation on the design of the bz_done log files. I love understanding how software works, and
the level of transparency of the staff and the software makes it possible.

### My Goals

With that being said, the GUI doesn't offer much information about what's happening during your backup. It tells you a
little bit but there is so much more it could say! Now, I realise that most of my issues are caused by the sheer size of
my backup, and the depth of the historical bz_done files I have. My Backblaze.bzpkg folder is just under 50GB which I
understand is very very unusual.
<div style="text-align: center;"><img alt="Screenshot of Backblaze GUI" height="300" src="img/CleanShot 2022-04-10 at 11.08.14@2x.png" width="400"/></div>

I'd like to have more information, more statistics, better progress bars etc.

- I want to know how many files I uploaded today.
- I want to know how much their 'Forever Version History' is costing me and which files exactly.
- I want to know exactly how much I'm exploiting Backblaze's generous business model, ie how much data do I have backed
  up when you remove the duplicates.
- I'd like a more elegant way to trigger a full re-scan and backup using the bztransmit tool.
    - And, I want to know how much longer it's going to take based on the last time it ran.
- I want to know **where** my data is, like which cluster, vault, and tome in their datacenter.

## Next steps...

Let's see how this goes...