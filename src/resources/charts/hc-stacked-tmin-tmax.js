// load the JSON data
fetch('/resources/wxdata/json/highest_temps_by_year.json')
  .then(response => response.json())
  .then(data => {
    // extract the years, highest_tmin, and highest_tmax from the JSON data
    const years = data.map(row => row[0]);
    const highest_tmin = data.map(row => row[1].highest_tmin);
    const highest_tmax = data.map(row => row[1].highest_tmax);

    // create the chart
    Highcharts.chart('stacked-tmin-tmax', {
      chart: {
        type: 'line' // change chart type to line
      },
      title: {
        text: 'Highest Low and High Temperatures by Year'
      },
      xAxis: {
        categories: years
      },
      yAxis: {
        title: {
          text: 'Temperature'
        },
        max: 120
      },
      series: [{
        id: 'highest_tmin',
        name: 'Highest TMIN',
        data: highest_tmin
      }, {
        id: 'highest_tmax',
        name: 'Highest TMAX',
        data: highest_tmax
      }, {
        type: 'trendline', // add trend line for highest_tmin
        name: 'TMIN Trend',
        linkedTo: 'highest_tmin',
        algorithm: 'linear',
        zIndex: 0,
        marker: {
          enabled: false
        }
      }, {
        type: 'trendline', // add trend line for highest_tmax
        name: 'TMAX Trend',
        linkedTo: 'highest_tmax',
        algorithm: 'linear',
        zIndex: 0,
        marker: {
          enabled: false
        }
      }]
    });
  });
