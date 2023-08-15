---
title: Chewing on Some Weather Data
slug: some-wx-data
description: I pulled a temperature dataset for my area and did a few things to it.
author: null
date: 2023-08-14T20:29:00:000Z
last_modified_at: 2023-08-14T20:29:00:000Z
draft: false
category: data
---

<!-- @format -->

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/stock/indicators/indicators.js"></script>
<script src="https://code.highcharts.com/stock/indicators/trendline.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

I had a few spare minutes this evening and with it being so dang hot this week, I wanted to pull some local weather data from NOAA and get an idea of how our temperatures have looked over time.

Everything I've crunched is in [`/misc/weather`](https://github.com/johlym/johnathan-org/tree/main/misc/weather), including the Ruby scripts I used to manipulate the data. The JSON data behind the charts is in [`/resources/wxdata`](https://github.com/johlym/johnathan-org/tree/main/resources/wxdata)

I've turned the summaries into charts.

## Highest Temperature by Month/Year

<div id="tmax-month-chart-container"></div>

<script defer src="/resources/charts/hc-tmax.js"></script>

## Number of Months with a High Temperature Over 90F

<div id="tmax-over-90"></div>

<script defer src="/resources/charts/hc-over90.js"></script>

## Highest Low and High Temperatures by Year

<div id="stacked-tmin-tmax"></div>

<script defer src="/resources/charts/hc-stacked-tmin-tmax.js"></script>
