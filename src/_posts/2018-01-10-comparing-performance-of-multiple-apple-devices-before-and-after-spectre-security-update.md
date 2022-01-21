---
title: Comparing Performance of Multiple Apple Devices Before and After Spectre Security
  Update
slug: comparing-performance-of-multiple-apple-devices-before-and-after-spectre-security-update
featured: false
og_title: Comparing Performance of Multiple Apple Devices Before and After Spectre
  Security Update – Johnathan.org
og_description: I spent some time this evening putting together some fun tables and
  graphs after seeing a post by Melvin Mughal on his blog that the iOS 11.2.2 update
  slows dow
meta_title: Comparing Performance of Multiple Apple Devices Before and After Spectre
  Security Update – Johnathan.org
meta_description: A hand-crafted technology product by Johnathan Lyman
layout: post
categories: posts
date: 2018-01-10 18:20:49.000000000 -08:00
---

I spent some time this evening putting together some fun tables and graphs after seeing a post by [Melvin Mughal on his blog](https://melv1n.com/iphone-performance-benchmarks-after-spectre-update/) that the iOS 11.2.2 update slows down devices by something like 40%. I didn’t believe it, so I fired up all the iDevices I own and benchmarked them before and after the Spectre-fixing update.

**January 11 Update** : I’ve added links to the Geekbench results at the end of the post for those needing verification of these numbers.

TL;DR: For my three devices, there was no difference in synthetic performance. This isn’t to say that real-world won’t be affected, but since those on the Internet were using synthetic benchmarks to prove their point, I opted to do the same to disprove.

**Statistical Note:** These measurements were taken using the latest-at-the-time for when the measurements were taken. The measurement of the iPhone X on iOS version 11.1 was taken on November 3, 2017 using Geekbench version 4.2.0. For all other measurements of all other pre-11.2.2 versions, they were taken with Geekbench version 4.2.1.

## Summary

Based on the data I was able to collect, I was not able to reproduce the dramatic drop in performance that some are reporting. A couple reasons for this could be that Melvin’s test was performed using an iPhone 6 which may be subject to an elder battery and thus throttling brought about in iOS 11.2. This throttling is in place to prevent the hardware from pulling a higher voltage than the battery can offer. This is a natural cycle of evolution of batteries of this type.

Another possibility is simply that I did not have an iPhone 6 to test. it is possible that a well-performing iPhone 6 is subject to greater performance woes than my newer iPhone X and iPad Pro 10.5”, though that doesn’t explain the inconsequential difference in performance from my iPad Mini 2, a device that uses a much older chipset than an iPhone 6.

### Single Core


| Device | Difference % After Updating from X to 11.2.2 |
| --- | --- |
| iPhone X (11.1) | 0.21% |
| iPad Pro 10.5” (11.2.1) | 3.56% |
| iPad Mini 2 (11.1.2) | 1.20% |


### Multi Core


| Device | Difference % After Updating from X to 11.2.2 |
| --- | --- |
| iPhone X (11.1) | -0.27% |
| iPad Pro 10.5” (11.2.1) | -0.39% |
| iPad Mini 2 (11.1.2) | -0.64% |


### Compute


| Device | Difference % After Updating from X to 11.2.2 |
| --- | --- |
| iPhone X (11.1) | -2.88% |
| iPad Pro 10.5” (11.2.1) | 1.94% |
| iPad Mini 2 (11.1.2) | -0.51% |


## Data Dump

### iPhone X

#### Single Core


| Benchmark | 11.1 | 11.2.2 | Difference % |
| --- | --- | --- | --- |
| **Score** | **4224** | **4233** | **0.21%** |
| Crypto | 3079 | 3075 | -0.13% |
| Integer | 4642 | 4665 | 0.50% |
| Floating Point | 3957 | 3940 | -0.43% |
| Memory | 3972 | 3991 | 0.48% |
| AES | 3079 | 3075 | -0.13% |
| LZMA | 3426 | 3483 | 1.66% |
| JPEG | 4149 | 4144 | -0.12% |
| Canny | 4326 | 4360 | 0.79% |
| Lua | 4717 | 4702 | -0.32% |
| Dijkstra | 4588 | 4766 | 3.88% |
| SQLite | 4263 | 4269 | 0.14% |
| HTML5 Parse | 4369 | 4378 | 0.21% |
| HTML5 DOM | 5002 | 4996 | -0.12% |
| Histogram Equalization | 4056 | 4058 | 0.05% |
| PDF Rendering | 4349 | 4341 | -0.18% |
| LLVM | 9010 | 9000 | -0.11% |
| Camera | 5089 | 5099 | 0.20% |
| SGEMM | 2566 | 2572 | 0.23% |
| SFFT | 3329 | 3330 | 0.03% |
| N-Body Physics | 3505 | 3434 | -2.03% |
| Ray Tracing | 4312 | 4349 | 0.86% |
| Rigid Body Physics | 4169 | 4126 | -1.03% |
| HDR | 5047 | 5043 | -0.08% |
| Gaussian Blur | 4664 | 4670 | 0.13% |
| Speech Recognition | 4049 | 4093 | 1.09% |
| Face Detection | 4637 | 4499 | -2.98% |
| Memory Copy | 4985 | 5010 | 0.50% |
| Memory Latency | 3899 | 3909 | 0.26% |
| Memory Bandwidth | 3225 | 3248 | 0.71% |


#### Multi Core


| Benchmark | 11.1 | 11.2.2 | Difference % |
| --- | --- | --- | --- |
| **Score** | **10242** | **10270** | **-0.27%** |
| Crypto | 7708 | 7650 | -0.75% |
| Integer | 13223 | 13367 | 1.09% |
| Floating Point | 10322 | 10193 | -1.25% |
| Memory | 4050 | 4070 | 0.49% |
| AES | 7708 | 7650 | -0.75% |
| LZMA | 11340 | 10957 | -3.38% |
| JPEG | 13128 | 13478 | 2.67% |
| Canny | 11899 | 13523 | 13.65% |
| Lua | 12792 | 13201 | 3.20% |
| Dijkstra | 13461 | 12878 | -4.33% |
| SQLite | 11514 | 11128 | -3.35% |
| HTML5 Parse | 13110 | 12705 | -3.09% |
| HTML5 DOM | 12256 | 12392 | 1.11% |
| Histogram Equalization | 11595 | 11753 | 1.36% |
| PDF Rendering | 11613 | 11582 | -0.27% |
| LLVM | 22546 | 25807 | 14.46% |
| Camera | 14724 | 15444 | 4.89% |
| SGEMM | 5876 | 5663 | -3.62% |
| SFFT | 9338 | 9503 | 1.77% |
| N-Body Physics | 9770 | 9560 | -2.15% |
| Ray Tracing | 10725 | 10370 | -3.31% |
| Rigid Body Physics | 11873 | 12931 | 8.91% |
| HDR | 15497 | 14517 | -6.32% |
| Gaussian Blur | 10896 | 11018 | 1.12% |
| Speech Recognition | 9433 | 9452 | 0.20% |
| Face Detection | 12238 | 11397 | -6.87% |
| Memory Copy | 5798 | 5815 | 0.29% |
| Memory Latency | 3563 | 3560 | -0.08% |
| Memory Bandwidth | 3217 | 3259 | 1.31% |


#### Compute


| Benchmark | 11.1 | 11.2.2 | % Difference |
| --- | --- | --- | --- |
| **Score** | **15306** | **14865** | **-2.88%** |
| Histogram Equalization | 12075 | 11719 | -2.95% |
| SFFT | 2755 | 2759 | 0.15% |
| Gaussian Blur | 25486 | 22871 | -10.26% |
| Face Detection | 10371 | 9841 | -5.11% |
| Sobel | 11861 | 9726 | -18.00% |
| RAW | 50942 | 58955 | 15.73% |
| Depth of Field | 26303 | 26654 | 1.33% |
| Particle Physics | 21566 | 21437 | -0.60% |


### iPad Pro 10.5”

#### Single Core


| Benchmark | 11.2.1 | 11.2.2 | Difference % |
| --- | --- | --- | --- |
| **Score** | **3824** | **3960** | **3.56%** |
| Crypto | 2402 | 2498 | 4.00% |
| Integer | 4039 | 4174 | 3.34% |
| Floating Point | 3421 | 3550 | 3.77% |
| Memory | 4299 | 4461 | 3.77% |
| AES | 2402 | 2498 | 4.00% |
| LZMA | 3231 | 3629 | 12.32% |
| JPEG | 3560 | 3674 | 3.20% |
| Canny | 3693 | 3713 | 0.54% |
| Lua | 4154 | 4305 | 3.64% |
| Dijkstra | 4565 | 4793 | 4.99% |
| SQLite | 3676 | 3751 | 2.04% |
| HTML5 Parse | 3858 | 3907 | 1.27% |
| HTML5 DOM | 4520 | 4658 | 3.05% |
| Histogram Equalization | 3389 | 3404 | 0.44% |
| PDF Rendering | 3441 | 3519 | 2.27% |
| LLVM | 7622 | 7894 | 3.57% |
| Camera | 4116 | 4247 | 3.18% |
| SGEMM | 2324 | 2398 | 3.18% |
| SFFT | 2816 | 2892 | 2.70% |
| N-Body Physics | 3211 | 3323 | 3.49% |
| Ray Tracing | 3447 | 3642 | 5.66% |
| Rigid Body Physics | 3654 | 3811 | 4.30% |
| HDR | 4088 | 4190 | 2.50% |
| Gaussian Blur | 3780 | 3898 | 3.12% |
| Speech Recognition | 3940 | 4359 | 10.63% |
| Face Detection | 3987 | 3933 | -1.35% |
| Memory Copy | 5369 | 5479 | 2.05% |
| Memory Latency | 3659 | 3693 | 0.93% |
| Memory Bandwidth | 4047 | 4389 | 8.45% |


#### Multi Core


| Benchmark | 11.2.1 | 11.2.2 | Difference % |
| --- | --- | --- | --- |
| **Score** | **9408** | **9445** | **0.39%** |
| Crypto | 7188 | 7190 | 0.03% |
| Integer | 11469 | 11482 | 0.11% |
| Floating Point | 9658 | 9658 | 0.00% |
| Memory | 4951 | 5109 | 3.19% |
| AES | 7188 | 7190 | 0.03% |
| LZMA | 9521 | 9514 | -0.07% |
| JPEG | 10576 | 10577 | 0.01% |
| Canny | 10522 | 10519 | -0.03% |
| Lua | 12011 | 12065 | 0.45% |
| Dijkstra | 11461 | 11349 | -0.98% |
| SQLite | 9728 | 10075 | 3.57% |
| HTML5 Parse | 11203 | 11264 | 0.54% |
| HTML5 DOM | 12810 | 12467 | -2.68% |
| Histogram Equalization | 9790 | 9798 | 0.08% |
| PDF Rendering | 9626 | 9619 | -0.07% |
| LLVM | 21986 | 22188 | 0.92% |
| Camera | 12281 | 12245 | -0.29% |
| SGEMM | 6667 | 6654 | -0.19% |
| SFFT | 8360 | 8372 | 0.14% |
| N-Body Physics | 9544 | 9550 | 0.06% |
| Ray Tracing | 9956 | 10031 | 0.75% |
| Rigid Body Physics | 10993 | 10997 | 0.04% |
| HDR | 12055 | 11810 | -2.03% |
| Gaussian Blur | 11130 | 11064 | -0.59% |
| Speech Recognition | 8572 | 8595 | 0.27% |
| Face Detection | 10925 | 11103 | 1.63% |
| Memory Copy | 7169 | 7425 | 3.57% |
| Memory Latency | 3694 | 3744 | 1.35% |
| Memory Bandwidth | 4585 | 4798 | 4.65% |


#### Compute


| Benchmark | 11.2.1 | 11.2.2 | % Difference |
| --- | --- | --- | --- |
| **Score** | **30832** | **30233** | **-1.94%** |
| Histogram Equalization | 21093 | 20851 | -1.15% |
| SFFT | 4848 | 4885 | 0.76% |
| Gaussian Blur | 54249 | 58809 | 8.41% |
| Face Detection | 12272 | 11940 | -2.71% |
| Sobel | 33126 | 29732 | -10.25% |
| RAW | 167227 | 170189 | 1.77% |
| Depth of Field | 71228 | 68612 | -3.67% |
| Particle Physics | 34041 | 28111 | -17.42% |


### iPad Mini 2

#### Single Core


| Benchmark | 11.1.2 | 11.2.2 | Difference % |
| --- | --- | --- | --- |
| **Score** | **1255** | **1270** | **1.20%** |
| Crypto | 668 | 753 | 12.72% |
| Integer | 1302 | 1306 | 0.31% |
| Floating Point | 1172 | 1201 | 2.47% |
| Memory | 1418 | 1423 | 0.35% |
| AES | 668 | 753 | 12.72% |
| LZMA | 1035 | 1282 | 23.86% |
| JPEG | 1493 | 1504 | 0.74% |
| Canny | 1319 | 1416 | 7.35% |
| Lua | 1228 | 1222 | -0.49% |
| Dijkstra | 1295 | 1367 | 5.56% |
| SQLite | 1075 | 1051 | -2.23% |
| HTML5 Parse | 1235 | 1243 | 0.65% |
| HTML5 DOM | 1124 | 900 | -19.93% |
| Histogram Equalization | 1326 | 1323 | -0.23% |
| PDF Rendering | 1140 | 1124 | -1.40% |
| LLVM | 2066 | 1947 | -5.76% |
| Camera | 1584 | 1586 | 0.13% |
| SGEMM | 767 | 767 | 0.00% |
| SFFT | 1250 | 1255 | 0.40% |
| N-Body Physics | 889 | 893 | 0.45% |
| Ray Tracing | 1091 | 1165 | 6.78% |
| Rigid Body Physics | 1388 | 1391 | 0.22% |
| HDR | 1685 | 1675 | -0.59% |
| Gaussian Blur | 1316 | 1319 | 0.23% |
| Speech Recognition | 1185 | 1207 | 1.86% |
| Face Detection | 1234 | 1402 | 13.61% |
| Memory Copy | 1379 | 1383 | 0.29% |
| Memory Latency | 2215 | 2218 | 0.14% |
| Memory Bandwidth | 935 | 940 | 0.53% |


#### Multi Core


| Benchmark | 11.1.2 | 11.2.2 | Difference % |
| --- | --- | --- | --- |
| **Score** | **2184** | **2170** | **-0.64%** |
| Crypto | 1472 | 1471 | -0.07% |
| Integer | 2430 | 2374 | -2.30% |
| Floating Point | 2268 | 2308 | 1.76% |
| Memory | 1681 | 1679 | -0.12% |
| AES | 1472 | 1471 | -0.07% |
| LZMA | 2337 | 2351 | 0.60% |
| JPEG | 2935 | 2955 | 0.68% |
| Canny | 2732 | 2715 | -0.62% |
| Lua | 2456 | 2314 | -5.78% |
| Dijkstra | 2534 | 2534 | 0.00% |
| SQLite | 2084 | 1959 | -6.00% |
| HTML5 Parse | 2440 | 2400 | -1.64% |
| HTML5 DOM | 1121 | 1110 | -0.98% |
| Histogram Equalization | 2532 | 2454 | -3.08% |
| PDF Rendering | 2114 | 2043 | -3.36% |
| LLVM | 3855 | 3591 | -6.85% |
| Camera | 3099 | 3098 | -0.03% |
| SGEMM | 1475 | 1471 | -0.27% |
| SFFT | 2460 | 2469 | 0.37% |
| N-Body Physics | 1760 | 1754 | -0.34% |
| Ray Tracing | 2223 | 2285 | 2.79% |
| Rigid Body Physics | 2751 | 2762 | 0.40% |
| HDR | 3258 | 3265 | 0.21% |
| Gaussian Blur | 2553 | 2555 | 0.08% |
| Speech Recognition | 2013 | 2029 | 0.79% |
| Face Detection | 2436 | 2732 | 12.15% |
| Memory Copy | 1884 | 1890 | 0.32% |
| Memory Latency | 2244 | 2242 | -0.09% |
| Memory Bandwidth | 1124 | 1119 | -0.44% |


#### Compute


| Benchmark | 11.1.2 | 11.2.2 | % Difference |
| --- | --- | --- | --- |
| **Score** | **587** | **584** | **-0.51%** |
| Histogram Equalization | 325 | 318 | -2.15% |
| SFFT | 35 | 35 | 0.00% |
| Gaussian Blur | 365 | 366 | 0.27% |
| Face Detection | 647 | 645 | -0.31% |
| Sobel | 414 | 408 | -1.45% |
| RAW | 1709 | 1704 | -0.29% |
| Depth of Field | 2171 | 2170 | -0.05% |
| Particle Physics | 3421 | 3423 | 0.06% |


## Sources

- iPhone X
  - Single Core/Multi Core: [11.1](https://browser.geekbench.com/v4/cpu/6341169), [11.2.2](https://browser.geekbench.com/v4/cpu/6341173)
  - Compute: [11.1](https://browser.geekbench.com/v4/compute/1813909), [11.2.2](https://browser.geekbench.com/v4/compute/1813904)
- iPad Pro 10.5”
  - Single Core/Multi Core: [11.2.1](https://browser.geekbench.com/v4/cpu/6341209), [11.2.2](https://browser.geekbench.com/v4/cpu/6341226)
  - Compute: [11.2.1](https://browser.geekbench.com/v4/compute/1813929), [11.2.2](https://browser.geekbench.com/v4/compute/1813937)
- iPad Mini 2
  - Single Core/Multi Core: [11.1.2](https://browser.geekbench.com/v4/cpu/6341266), [11.2.2](https://browser.geekbench.com/v4/cpu/6341280)
  - Compute: [11.1.2](https://browser.geekbench.com/v4/compute/1813952), [11.2.2](https://browser.geekbench.com/v4/compute/1813956)
