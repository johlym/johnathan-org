---
title: "Linode vs Digital Ocean: A Three-Round VPS Benchmark Showdown"
featured: false
layout: post
date: 2018-01-18 10:05:48 -08:00
last_modified_at: 2022-02-28T23:28:56.281Z
category: technology
---

A few days ago, [Digital Ocean](https://digitalocean.com) announced new pricing tiers for their VPSes (affectionately called Droplets). I've been a fan of Digital Ocean's offerings for a long time. Compared to other popular VPS provider [Linode](https://linode.com), there seemed like there was only one choice as Digital Ocean's pricing ran 2x for almost everything.

Now that they're the same price, I think it's about time they faceoff in a set of sysbench benchmark tests.

Both providers offer the standard set of plans, though each has unique offerings as well. Linode provides “high memory” options ranging from 16GB to 200GB of RAM, whereas Digital Ocean offers “high CPU” choices, advertising similar vCPU quantites but backed by compute-oriented hardware. We'll leave those specific offerings off the table for now and just point a few standard VPSes from each provider at each other and see who comes out on top.

The results are broken down into each RAM category: 1GB, 4GB, and 8GB, comparing each provider's offerings for each tier individually. The best scores for each cateogry and test are in **bold**.

_Before I begin, I want to give special thanks to [Josh Sherman](https://twitter.com/joshtronic). He came up with a great [$5 comparison](https://joshtronic.com/2017/02/14/five-dollar-showdown-linode-vs-digitalocean-vs-lightsaild-vs-vultr/) list back in February 2017 that served as inspiration for this post._

## The Loadouts

We'll be testing the following configurations from each provider:

### Digital Ocean


| RAM | vCPUs | Storage | Transfer | Price |
| --- | --- | --- | --- | --- |
| 1GB | 1 | 25GB | 1TB | $5.00/month or $0.007/hour |
| 4GB | 2 | 80GB | 4TB | $20/month or $0.030/hour |
| 8GB | 4 | 160GB | 5TB | $40/month or $0.060/hour |


### Linode


| RAM | vCPUs | Storage | Transfer | Price |
| --- | --- | --- | --- | --- |
| 1GB | 1 | 20GB | 1TB | $5.00/month or $0.007/hour |
| 4GB | 2 | 48GB | 3TB | $20/month or $0.030/hour |
| 8GB | 4 | 96GB | 4TB | $40/month or $0.060/hour |


### Deployment Notes

- The latest Ubuntu 16.04.3 x64 provided by Linode and Digital Ocean will be installed.
- Each VPS will be fresh out of the box and updated to the latest version of everything pre-packaged.
- `sysbench` will be used to measure performance on all nodes using the same commands.
- All VPSes were tested in their respective California regions (Digital Ocean: SFO 2, Linode: Fremont, CA)
- Running the prep commands on Linode took much longer than Digital Ocean. It seems the Digital Ocean image of Ubuntu 16.04.3 is much more up to date.

#### Prepatory commands

```sh
apt-get update
apt-get upgrade -y
apt-get install apache2 apache2-utils mysql-server mysql-client speedtest-cli sysbench -y
```

During Linode provisioning, each VPS had trouble connecting to `security.ubuntu.com` via IPv6 so I had to edit `etc/gai.conf` to force IPV4 by uncommenting this line:

```
#precedence ::ffff:0:0/96 100
```

## CPU Info

```sh
cat /proc/cpuinfo
```

### Digital Ocean


| RAM | Model | MHz | Cache | BogoMips |
| --- | --- | --- | --- | --- |
| 1GB | Intel(R) Xeon(R) CPU E5-2650 v4 | 2.20Ghz | 30MB | 4400 |
| 4GB | Intel(R) Xeon(R) CPU E5-2650 v4 | 2.20Ghz | 30MB | 4400 |
| 8GB | Intel(R) Xeon(R) CPU E5-2650L v3 | 1.80Ghz | 30MB | 3600 |


### Linode


| RAM | Model | MHz | Cache | BogoMips |
| --- | --- | --- | --- | --- |
| 1GB | Intel(R) Xeon(R) CPU E5-2680 v3 | 2.50Ghz | 16MB | 5001 |
| 4GB | Intel(R) Xeon(R) CPU E5-2680 v2 | 2.80Ghz | 16MB | 5602 |
| 8GB | Intel(R) Xeon(R) CPU E5-2680 v3 | 2.50Ghz | 16MB | 5001 |


## The Results

### 1GB — $5.00/month

#### CPU

```sh
sysbench --test=cpu run
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Events | 10,000 | 10,000 |
| Total Time | **12.6051s** | 16.5311s |
| Event Execution | **12.6017s** | 16.5197s |
| Minimum Request | 1.24ms | **1.16ms** |
| Average Request | **1.26ms** | 1.65ms |
| Maximum Request | **3.05ms** | 29.83ms<sup id="fnref-1"><a href="#fn-1" class="footnote">1</a></sup> |
| p95 | **1.29ms** | 2.00ms |


#### Memory

##### **Read**

```sh
sysbench --test=memory run
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Events | 104,857,600 | 104,857,600 |
| Total Time | **49.9387s** | 226.27s |
| Execution Time | **41.3406s** | 176.5801s |
| Minimum Request | **0.00ms** | **0.00ms** |
| Average Request | **0.00ms** | **0.00ms** |
| Maximum Request | **14.56ms** | 36.81ms |
| 95th Percentile | **0.00ms** | **0.00ms** |
| Operations/Second | **2,099,725/sec** | 463,417/sec |
| MB/Second | **2,050.02 MB/sec** | 453.34 MB/sec |



**Write**

```sh
sysbench --test=memory --memory-oper=write run
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Events | 104,857,600 | 104,857,600 |
| Total Time | **50.0363s** | 226.0851s |
| Execution Time | **41.4121s** | 176.1462s |
| Minimum Request | **0.00ms** | **0.00ms** |
| Average Request | **0.00ms** | **0.00ms** |
| Maximum Request | **3.67ms** | 41.21ms |
| 95th Percentile | **0.00ms** | **0.00ms** |
| Operations/Second | **2,095,630/sec** | 463,797/sec |
| MB/Second | **2,046 MB/sec** | 453 MB/sec |


#### File I/O

```sh
sysbench --test=fileio prepare
sysbench --test=fileio --file-test-mode=rndrw run
sysbench --test=fileio cleanup
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Events | 10,000 | 10,000 |
| Total Time | 5.1085s | **2.1141s** |
| Execution Time | 3.0602s | **0.6239s** |
| Minimum Request | **0.00ms** | 0.01ms |
| Average Request | 0.31ms | **0.06ms** |
| Maximum Request | 52.63ms | **11.99ms** |
| 95th Percentile | 0.40ms | **0.13ms** |
| Requests/Second | 1,957/sec | **4,730/sec** |
| MB/Second | 30.586 MB/sec | **73.909 MB/sec** |


#### Apps: Apache

```sh
ab -kc 1000 -n 10000 http://127.0.0.1/
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Concurrency Level | 1000 | 1000 |
| Time Taken (seconds) | 7.024s | **7.051s** |
| Completed Requests | 10,000 | 10,000 |
| Failed Requests | 377 | **108** |
| Requests/sec (mean) | 1,423.65 | **1,418.22** |
| Time per request (mean) | **702.418ms** | 705.108ms |
| Transfer Rate | 15,560 KB/sec | **15,934 KB/sec** |


#### Apps: MySQL

```sh
mysql -uroot -e "CREATE DATABASE sbtest;"
sysbench --test=oltp --oltp-table-size=1000000 --mysql-user=root prepare
sysbench --test=oltp --oltp-table-size=1000000 --mysql-user=root run
sysbench --test=oltp --oltp-table-size=1000000 --mysql-user=root cleanup
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Queries | 210,000 | 210,000 |
| Total Time | **44.5271s** | 64.2293s |
| Execution Time | **44.4597s** | 64.0938s |
| Minimum Request | **2.02ms** | 2.85ms |
| Average Request | **4.45ms** | 6.41ms |
| Maximum Request | 545.68ms<sup id="fnref-1:1"><a href="#fn-1" class="footnote">1</a></sup> | **67.22ms** |
| 95th Percentile | **5.39ms** | 13.86ms |
| Read/Write Requests/sec | **4,267.07/sec** | 2,958.15/sec |
| Transactions/sec | **224.58/sec** | 155.69/sec |
| Other Operations/sec | **449.17/sec** | 311.38/sec |


#### Apps: Speedtest

```sh
speedtest-cli --server=5479
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Distance | 30.81km | 3618.50km<sup id="fnref-2"><a href="#fn-2" class="footnote">2</a></sup> |
| Ping | 49.611ms | **33.425ms** |
| Download | 1040.06 Mbit/sec | **1,392.52 Mbit/sec** |
| Upload | **387.06 Mbit/sec** | 258.02 Mbit/sec |


### 4GB — $20.00/month

#### CPU

```sh
sysbench --test=cpu run
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Events | 10,000 | 10,000 |
| Total Time | **12.4283s** | 13.22173s |
| Event Execution | **12.4257s** | 13.2114s |
| Minimum Request | **1.16ms** | **1.16ms** |
| Average Request | **1.24ms** | 1.32ms |
| Maximum Request | **4.47ms** | 4.49ms |
| p95 | **1.51ms** | 1.64ms |


#### Memory

##### **Read**

```sh
sysbench --test=memory run
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Events | 104,857,600 | 104,857,600 |
| Total Time | **46.0665s** | 178.6187s |
| Execution Time | **38.1407s** | 138.1447s |
| Minimum Request | **0.00ms** | **0.00ms** |
| Average Request | **0.00ms** | **0.00ms** |
| Maximum Request | **2.42ms** | 5.29ms |
| 95th Percentile | **0.00ms** | **0.00ms** |
| Operations/Second | **2,276,220/sec** | 587,047/sec |
| MB/Second | **2,222.87 MB/sec** | 573.29 MB/sec |



**Write**

```sh
sysbench --test=memory --memory-oper=write run
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Events | 104,857,600 | 104,857,600 |
| Total Time | **45.3632s** | 191.1536s |
| Execution Time | **37.5572s** | 148.0344s |
| Minimum Request | **0.00ms** | **0.00ms** |
| Average Request | **0.00ms** | **0.00ms** |
| Maximum Request | **5.98ms** | 17.05ms |
| 95th Percentile | **0.00ms** | **0.00ms** |
| Operations/Second | **2,311,510.22/sec** | 548,551.45/sec |
| MB/Second | **2,257.33 MB/sec** | 535.68 MB/seec |


#### File I/O

```sh
sysbench --test=fileio prepare
sysbench --test=fileio --file-test-mode=rndrw run
sysbench --test=fileio cleanup
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Events | 10,000 | 10,000 |
| Total Time | 1.6893s | **1.6235s** |
| Execution Time | **0.0930s** | 0.1605s |
| Minimum Request | **0.00ms** | **0.00ms** |
| Average Request | **0.01ms** | 0.02ms |
| Maximum Request | **0.11ms** | 4.19ms |
| 95th Percentile | **0.02ms** | 0.03ms |
| Requests/Second | 5,919.56/sec | **6,159.62/sec** |
| MB/Second | **92.493 MB/sec** | 96.244 MB/sec |


#### Apps: Apache

```sh
ab -kc 1000 -n 10000 http://127.0.0.1/
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Concurrency Level | 1000 | 1000 |
| Time Taken (seconds) | **2.426s** | 5.902s |
| Completed Requests | 10,000 | 10,000 |
| Failed Requests | 301 | **292** |
| Requests/sec (mean) | **4,121.64/sec** | 1,694.42 |
| Time per request (mean) | **242.622ms** | 590.172ms |
| Transfer Rate | **45,405.85 KB/sec** | 18,697.41 KB/sec |


#### Apps: MySQL

```sh
mysql -uroot -e "CREATE DATABASE sbtest;"
sysbench --test=oltp --oltp-table-size=1000000 --mysql-user=root prepare
sysbench --test=oltp --oltp-table-size=1000000 --mysql-user=root run
sysbench --test=oltp --oltp-table-size=1000000 --mysql-user=root cleanup
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Queries | 210,000 | 210,000 |
| Total Time | **36.16s** | 55.3371s |
| Execution Time | **36.1036s** | 55.2440s |
| Minimum Request | **2.25ms** | 2.27ms |
| Average Request | **3.61ms** | 5.52ms |
| Maximum Request | **359.96ms** | 1141.29ms<sup id="fnref-1:2"><a href="#fn-1" class="footnote">1</a></sup> |
| 95th Percentile | **4.83ms** | 10.45ms |
| Read/Write Requests/sec | **5,254.43/sec** | 3,433.50/sec |
| Transactions/sec | **276.55/sec** | 180.71/sec |
| Other Operations/sec | **553.10/sec** | 361.42/sec |


#### Apps: Speedtest

```sh
speedtest-cli --server=5479
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Distance | 30.81km | 4101.95km<sup id="fnref-2:1"><a href="#fn-2" class="footnote">2</a></sup> |
| Ping | 66.529ms | **5.036ms** |
| Download | **1,432.71 Mbit/sec** | 1118.17 Mbit/sec |
| Upload | **344.86 Mbit/sec** | 314.71 Mbit/sec |


### 8GB — $40.00/month

#### CPU

```sh
sysbench --test=cpu run
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Events | 10,000 | 10,000 |
| Total Time | **13.7149s** | 15.0707s |
| Event Execution | **13.7105s** | 15.0640s |
| Minimum Request | **1.24ms** | 1.47ms |
| Average Request | **1.37ms** | 1.51ms |
| Maximum Request | **2.94ms** | 3.28ms |
| p95 | **1.50ms** | 1.52ms |


#### Memory

##### **Read**

```sh
sysbench --test=memory run
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Events | 104,857,600 | 104,857,600 |
| Total Time | **55.1697s** | 196.5439s |
| Execution Time | **45.6143s** | 151.9530s |
| Minimum Request | **0.00ms** | **0.00ms** |
| Average Request | **0.00ms** | **0.00ms** |
| Maximum Request | 11.02ms | **2.03ms** |
| 95th Percentile | **0.00ms** | **0.00ms** |
| Operations/Second | **1,900,637.74/sec** | 533,501.80/sec |
| MB/Second | **1,856.09 MB/sec** | 521 MB/sec |



**Write**

```sh
sysbench --test=memory --memory-oper=write run
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Events | 104,857,600 | 104,857,600 |
| Total Time | **62.5355s** | 202.5272s |
| Execution Time | **51.6640s** | 156.6225s |
| Minimum Request | **0.00ms** | **0.00ms** |
| Average Request | **0.00ms** | **0.00ms** |
| Maximum Request | 4.36ms | **2.22ms** |
| 95th Percentile | **0.00ms** | **0.00ms** |
| Operations/Second | **1,676.770.31/sec** | 517,745.73/sec |
| MB/Second | **1,637.47 MB/sec** | 505.61 MB/sec |


#### File I/O

```sh
sysbench --test=fileio prepare
sysbench --test=fileio --file-test-mode=rndrw run
sysbench --test=fileio cleanup
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Events | 10,000 | 10,000 |
| Total Time | 2.1398s | **1.1296s** |
| Execution Time | **0.0854s** | 0.1273s |
| Minimum Request | **0.00ms** | **0.00ms** |
| Average Request | **0.01ms** | **0.01ms** |
| Maximum Request | **0.07ms** | 0.13ms |
| 95th Percentile | **0.01ms** | 0.03ms |
| Requests/Second | 4,673.39/sec | **8,852.78/sec** |
| MB/Second | 73.022 MB/sec | **138.32 MB/sec** |


#### Apps: Apache

```sh
ab -kc 1000 -n 10000 http://127.0.0.1/
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Concurrency Level | 1000 | 1000 |
| Time Taken (seconds) | **5.778s** | 5.803s |
| Completed Requests | 10,000 | 10,000 |
| Failed Requests | 450 | **332** |
| Requests/sec (mean) | **1,730.67/sec** | 1,723.18/sec |
| Time per request (mean) | **577.811ms** | 580.323ms |
| Transfer Rate | 18,733.09 KB/sec | **18,946.15 KB/sec** |


#### Apps: MySQL

```sh
mysql -uroot -e "CREATE DATABASE sbtest;"
sysbench --test=oltp --oltp-table-size=1000000 --mysql-user=root prepare
sysbench --test=oltp --oltp-table-size=1000000 --mysql-user=root run
sysbench --test=oltp --oltp-table-size=1000000 --mysql-user=root cleanup
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Number of Queries | 210,000 | 210,000 |
| Total Time | 38.8435s | **38.5574s** |
| Execution Time | 38.7863s | **38.4869s** |
| Minimum Request | **2.06ms** | 2.75ms |
| Average Request | 3.88ms | **3.85ms** |
| Maximum Request | **46.47ms** | 304.95ms<sup id="fnref-1:3"><a href="#fn-1" class="footnote">1</a></sup> |
| 95th Percentile | 5.29ms | **4.71ms** |
| Read/Write Requests/sec | 4,891.42/sec | **4,927.71/sec** |
| Transactions/sec | 257.44/sec | **259.35/sec** |
| Other Operations/sec | 514.89/sec | **518.71/sec** |


#### Apps: Speedtest

```sh
speedtest-cli --server=5479
```


| &nbsp; | Linode | Digital Ocean |
| --- | --- | --- |
| Distance | 30.81km | 4101.95km<sup id="fnref-2:2"><a href="#fn-2" class="footnote">2</a></sup> |
| Ping | 63.279ms | **55.343ms** |
| Download | **1,635.88 Mbit/sec** | 824.12 Mbit/sec |
| Upload | **275.91 Mbit/sec** | 262.63 Mbit/sec |


## Conclusion

Comparing both sets of VPSes against each other yielded mixed results. The Linoe VPSes ran away with the win in most categories, with Digital Ocean ending up the underdog winner. For CPU performance, both providers were pretty well in line. I wouldn't consider at 1.08x difference enough to warrant a migration or decision based on that stat alone. If Digital Ocean's High CPU offerings were in play, I would be surprised if they didn't take the cake.

Moving into the Memory tests, though, we see much larger gaps between the two. Linode was frequently ahead by as much at 4.5x, though the gap started to close as the VPSes increased in size. Raw bits/sec as well as time to execute were several times better. There's not much else to say here.

File IO was where we started seeing some mixed results, with Digital Ocean coming out as the leader. For the 1GB and 8GB VPSes, Digital Ocean ran away with the win in bytes/second, while Linode barely squeaked through.

Looking at application benchmarks, the MySQL tests were surprising, given the file I/O results. Apache seemed to line up with what we saw in terms of CPU performance and both providers had sexy-fast networks though Linode came out on top two out of three times.

At the end of the day, unless you're running highend workloads, these general purpose VPSes are likely to perform just about the same. Compute tasks are better served by offerings that are designed to be utilized for that purpose. If you need every bit of RAW in-memory power you can muster, Linode will likely offer better results overall.

The race to the bottom continues with Digital Ocean halfing their prices and I'm glad to see it happen. Given that there's still on-paper desparities between each provider, it made sense and I'm surprised they didn't do it sooner.

I look forward to testing these again in the future in hopes that backed by new/better hardware, [Digital Ocean](https://johnathan.org/goto/digitalocean) can surpass [Linode](https://www.linode.com/?r=2527e12c0aed087cbe51d3862f0a6bb6c5ab8f9a) and further boost the VPS wars that end up benefiting the consumer even more.

Expect more tests that include other providers like Vultur, Media Temple, Dreamhost, Lightsail, and more, perhaps even a mega comparo!

**Disclaimer** : The FTC requires I state that links in this article may be monetized.

1. A possible statistical outlier that would need to be reviewed and possibly re-tested. [↩](#fnref-1) [↩<sup>2</sup>](#fnref-1:1) [↩<sup>3</sup>](#fnref-1:2) [↩<sup>4</sup>](#fnref-1:3)
2. The geographic location doesn't match up with the ping and the location Digital Ocean says the server was located. My guess is based on Geo IP lookup, the IP is registered in Canada and threw this number off. [↩](#fnref-2) [↩<sup>2</sup>](#fnref-2:1) [↩<sup>3</sup>](#fnref-2:2)
