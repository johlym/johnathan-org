// load the JSON data
fetch('/resources/wxdata/json/tmax.json')
  .then(response => response.json())
  .then(data => {
    // create an object to store the data by year
    var dataByYear = {};

    // iterate over each row in the data array
    for (var i = 0; i < data.length; i++) {
      var row = data[i];

      // extract the year and month from the row
      var year = row[2];
      var month = row[3];
      var tmax = parseInt(row[4]);

      // create a new array for the year if it doesn't exist yet
      if (!dataByYear[year]) {
        dataByYear[year] = [];
      }

      // add the tmax value to the year's array for the month
      dataByYear[year][parseInt(month) - 1] = tmax;
    }

    // create an array of series objects for Highcharts
    var series = [];

    // iterate over each year in the dataByYear object
    for (var year in dataByYear) {
      if (dataByYear.hasOwnProperty(year)) {
        // create a new series object for the year
        var yearSeries = {
          name: year,
          data: dataByYear[year],
          yAxis: 0,
          fillColor: {
            linearGradient: [0, 0, 0, 300],
            stops: [
              [0, Highcharts.getOptions().colors[0]],
              [1, 'rgba(255,255,255,0)']
            ]
          }
        };

        // add the series object to the series array
        series.push(yearSeries);
      }
    }

    // create the Highcharts chart
    Highcharts.chart('tmax-month-chart-container', {
      chart: {
        type: 'area'
      },
      title: {
        text: 'Highest Temperature (F) by Month and Year'
      },
      xAxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
      },
      yAxis: {
        title: {
          text: 'TMAX'
        },
        max: 120
      },
      series: series
    });
  });