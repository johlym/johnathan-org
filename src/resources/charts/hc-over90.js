// load the JSON data
fetch('/resources/wxdata/json/over90.json')
  .then(response => response.json())
  .then(data => {
    // extract the years, highest_tmin, and highest_tmax from the JSON data
    // create an array of series objects for Highcharts
    var series = [{
      name: 'Count',
      data: data.slice(1).map(function(row) {
        return parseInt(row[1]);
      })
    }];

    // create the Highcharts chart
    Highcharts.chart('tmax-over-90', {
      chart: {
        type: 'column'
      },
      title: {
        text: 'Number of Months with High Temperature over 90F'
      },
      xAxis: {
        categories: data.slice(1).map(function(row) {
          return row[0];
        })
      },
      yAxis: {
        title: {
          text: 'Count'
        }
      },
      series: series
    });
  });