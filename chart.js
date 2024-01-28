let mkRoot = () => {
  let root = am5.Root.new("chart"); 
  root.setThemes([
    am5themes_Animated.new(root)
  ]);
  root.numberFormatter.set("numberFormat", "#.00");
  return root;
};

let mkChart = root =>
  root.container.children.push(
    am5xy.XYChart.new(root, {
      panX:       true,
      panY:       false,
      wheelY:     "zoomX",
      pinchZoomX: true,
      layout:     root.verticalLayout,
      scrollbarX: am5xy.XYChartScrollbar.new(root, {
        orientation: 'horizontal'
      })
    })
  );

let mkYAxisTemp = (root, chart) => {
  let yAxis = chart.yAxes.push(
    am5xy.ValueAxis.new(root, {
      autoZoom:        false,
      min:             -40,
      max:             100,
      renderer:        am5xy.AxisRendererY.new(root, {
        minGridDistance: 20
      })
    })
  );
  yAxis.get("renderer").labels.template.setAll({
    fontSize: "0.75em"
  });
  return yAxis;
};

let mkYAxisFlag = (root, chart) => {
  let yAxis = chart.yAxes.push(
    am5xy.ValueAxis.new(root, {
      autoZoom:        false,
      min:             0,
      max:             1,
      renderer:        am5xy.AxisRendererY.new(root, {
        minGridDistance: 20
      })
    })
  );
  yAxis.get("renderer").labels.template.setAll({
    fontSize: "0.75em"
  });
  return yAxis;
};

let mkYAxisPower = (root, chart) => {
  let yAxis = chart.yAxes.push(
    am5xy.ValueAxis.new(root, {
      autoZoom:        false,
      min:             0,
      renderer:        am5xy.AxisRendererY.new(root, {
        minGridDistance: 20
      })
    })
  );
  yAxis.get("renderer").labels.template.setAll({
    fontSize: "0.75em"
  });
  return yAxis;
};

let mkXAxis = (root, chart) => {
  let xAxis = chart.xAxes.push(
    am5xy.DateAxis.new(root, {
      baseInterval: { timeUnit: "hour", count: 1 },
      renderer:     am5xy.AxisRendererX.new(root, {
        minGridDistance: 50
      })
    })
  );
  xAxis.get("renderer").labels.template.setAll({
    fontSize:      "0.75em",
    location:      0,
    multiLocation: 0
  });
  return xAxis;
};

let mkSeriesConstructor = (dateFns, dateFnsTz, root, chart, xAxis, yAxis) => name => {
  let ret = am5xy.LineSeries.new(root, { 
    name:              name,
    xAxis:             xAxis,
    yAxis:             yAxis,
    valueYField:       "measurement",
    valueXField:       "instant",
    tooltipText:       "{measurement}\n{instant}",
    maskBullets:       false,
    minBulletDistance: 25
  });
  chart.series.push(ret);
  
  return ret;
};

let mkButton = (root, legend, text, color) => {
  let ret = legend.children.push(am5.Button.new(root, {
    active:      true,
    width:       20,
    height:      20,
    dx:          4,
    marginTop:   6,
    fill:        am5.color(color),
    tooltipText: text
  }));
  ret.get('background').setAll({
    fill: am5.color(color)
  });
  return ret;
};

let mkCurrentTimeRange = (dateFns, dateFnsTz, root, chart, xAxis) => data => {
  let now = new Date();
  let currentTime = xAxis.makeDataItem({
    value:    dateFns.addMinutes(now, -1).getTime(),
    endValue: dateFns.addMinutes(now, 1).getTime()
  });

  let axisFill = xAxis.createAxisRange(currentTime).get("axisFill");
  axisFill.setAll({
      fill:          am5.color('#85c7fc'),
      stroke:        am5.color('#85c7fc'),
      fillOpacity:   1,
      strokeWidth:   5,
      visible:       true,
      tooltip:       am5.Tooltip.new(root, {}),
      tooltipY:      0,
      showTooltipOn: "always"
  });
  axisFill.get("tooltip").adapters.add("bounds", () => chart.plotContainer.globalBounds());

  axisFill.adapters.add("tooltipText", (text, target) => {
    let instant = target.dataItem.get('value');
    let price = () => data.findLast(x => x.instant <= instant).centsPerKWh;
    return dateFnsTz.formatInTimeZone(new Date(instant), 'Europe/Helsinki', "yyyy-MM-dd HH:mm") +
          (data.length == 0 ? '' : "\n" + (price() > 0 ? price().toFixed(2) + " + " + (price()*0.24).toFixed(2) + " = " + (price()*1.24).toFixed(2) : price()) + " c/kwh");
  });
  return currentTime;
};

let mkWeekendRanges = (dateFns, root, xAxis) => interval => {
  dateFns.eachWeekendOfInterval(interval).forEach(x => {
    let weekend = xAxis.createAxisRange(xAxis.makeDataItem({
      value:    x.getTime(),
      endValue: dateFns.addHours(x, 24).getTime()
    }));
    weekend.set("userData", { weekend: true });
    weekend.get("axisFill").setAll({
        visible:      true,
        fillOpacity:  0.5,
        fillGradient: am5.LinearGradient.new(root, {
          stops: [{
            color: am5.color("#000000")
          }, {
            color: am5.color("#ffffff"),
            offset: 0.30
          }, {
            color: am5.color("#ffffff")
          }]
        })
    });
  });
};

let mkNightRanges = (dateFns, dateFnsTz, xAxis) => interval => {
  dateFns.eachDayOfInterval(interval).forEach(x => {
    let night = xAxis.createAxisRange(xAxis.makeDataItem({
      value:    dateFnsTz.zonedTimeToUtc(new Date(dateFnsTz.formatInTimeZone(x,                     'Europe/Helsinki', 'yyyy-MM-dd') + 'T22:00:00'), 'Europe/Helsinki').getTime(),
      endValue: dateFnsTz.zonedTimeToUtc(new Date(dateFnsTz.formatInTimeZone(dateFns.addDays(x, 1), 'Europe/Helsinki', 'yyyy-MM-dd') + 'T07:00:00'), 'Europe/Helsinki').getTime(),
    }));
    night.set("userData", { night: true });
    night.get("axisFill").setAll({
        fill:        am5.color('#0000ff'),
        fillOpacity: 0.05,
        visible:     true
    });
  });
};

let initData = series => data => {
  data = data.sort((a,b) => a.instant - b.instant);
  series.data.setAll(data);
};

let mkRangeInitializer = (dateFns, dateFnsTz, root, chart, xAxis, showWeekendsF, showNightsF) => (data, includeNightsAndWeekends) => {
  xAxis.axisRanges.clear();

  let currentTime = mkCurrentTimeRange(dateFns, dateFnsTz, root, chart, xAxis)(data);
  setInterval(() => {
    let now = new Date();
    currentTime.setAll({
      value:    now.getTime() - 1000*60*1,
      endValue: now.getTime() + 1000*60*1
    });
  }, 60000);

  let interval = {
    start: Math.min(...data.map(x => x.instant)),
    end:   Math.max(...data.map(x => x.instant))
  };

  if (includeNightsAndWeekends && showWeekendsF()) {
    mkWeekendRanges(dateFns, root, xAxis)(interval);
  }

  if (includeNightsAndWeekends && showNightsF()) {
    mkNightRanges(dateFns, dateFnsTz, xAxis)(interval);
  }
};

let initSeries = (dateFns, xAxis, series) => {
    series.events.once("datavalidated", ev =>
      xAxis.zoomToDates(dateFns.addHours(new Date(), -24),
                        new Date(Math.max(...ev.target.data.values.map(x => x.instant)))));
};

let mkLegend = (root, chart) =>
  chart.plotContainer.children.push(am5.Legend.new(root, {
    layout: root.verticalLayout
  }));

let initChart = (dateFns, dateFnsTz) => {
  let root = mkRoot();
  window.chart = mkChart(root);
  let yAxisTemp = mkYAxisTemp(root, chart);
  //let yAxisFlag = mkYAxisFlag(root, chart);
  //let yAxisPower = mkYAxisPower(root, chart);
  let xAxis = mkXAxis(root, chart);

  let mkSeriesTemp = mkSeriesConstructor(dateFns, dateFnsTz, root, chart, xAxis, yAxisTemp);
  //let mkSeriesFlag = mkSeriesConstructor(dateFns, dateFnsTz, root, chart, xAxis, yAxisFlag);
  //let mkSeriesPower = mkSeriesConstructor(dateFns, dateFnsTz, root, chart, xAxis, yAxisPower);

  let legend = mkLegend(root, chart);
  legend.data.setAll([]);

  /*let showNightsButton = mkButton(root, legend, "Show/hide nights", '#0000ff');
  let showWeekendsButton = mkButton(root, legend, "Show/hide weekends", '#000000');

  let initRanges = mkRangeInitializer(dateFns, dateFnsTz, root, chart, xAxis, () => showWeekendsButton.get('active'), () => showNightsButton.get('active'));

  showNightsButton.events.on("click", ev => {
    ev.target.set('active', !ev.target.get('active'));
    initRanges(mainSeries.data.values, true);
  });

  showWeekendsButton.events.on("click", ev => {
    ev.target.set('active', !ev.target.get('active'));
    initRanges(mainSeries.data.values, true);
  });
  */

  return (seriesName, type, data) => {
    let series = type === 'T' ? mkSeriesTemp(seriesName) : type === 'F' ? mkSeriesFlag(seriesName) : mkSeriesPower(seriesName);
    legend.data.setAll(legend.data.values.concat([series]));
    initSeries(dateFns, xAxis, series);
    initData(series)(data);
    //initRanges(data, baseInterval == 'hour');
  };
};