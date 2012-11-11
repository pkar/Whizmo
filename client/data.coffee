root = global ? window

Whizmo = Whizmo || {}
root.Whizmo = Whizmo

root.Whizmo.Data = {}

root.Whizmo.Data.timeSeries = [
  {date: '20111001', b1: 90.1, b2: 30.2, b3: 33.3, b4: 53.3},
  {date: '20111002', b1: 10.1, b2: 40.2, b3: 23.3, b4: 83.3},
  {date: '20111003', b1: 20.1, b2: 80.2, b3: 73.3, b4: 73.3},
  {date: '20111004', b1: 30.1, b2: 10.2, b3: 83.3, b4: 13.3},
]


root.Whizmo.Data.barChart = [
  {letter: 'Jan', $: 17859},
  {letter: 'Feb', $: 16628},
  {letter: 'Mar', $: 18107},
  {letter: 'Apr', $: 16867},
  {letter: 'May', $: 17944},
  {letter: 'Jun', $: 18867},
  {letter: 'Jul', $: 19226},
  {letter: 'Aug', $: 20199},
  {letter: 'Sep', $: 16866},
  {letter: 'Oct', $: 17900},
  {letter: 'Nov', $: 18253},
  {letter: 'Dec', $: 18496},
]

root.Whizmo.Data.Graph = {}

root.Whizmo.Data.Graph.TimeSeries = () ->

  console.log Buildings.find()
  Buildings.find({}).forEach (build) ->
    console.log build

  margin = {top: 30, right: 20, bottom: 30, left: 50}
  parseDate = d3.time.format("%Y%m%d").parse

  width = 900 - margin.left - margin.right
  height = 300 - margin.top - margin.bottom

  x = d3.time.scale().range([0, width])
  y = d3.scale.linear().range([height, 0])

  color = d3.scale.category10()

  xAxis = d3.svg.axis().scale(x).orient("bottom")
  yAxis = d3.svg.axis().scale(y).orient("left")

  line = d3.svg.line()
    .interpolate("basis")
    .x((d) -> x(d.date))
    .y((d) -> y(d.kwh))

  svg = d3.select("#timeseries").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

  data = root.Whizmo.Data.timeSeries

  color.domain(d3.keys(data[0]).filter((key) -> key isnt "date"))
  data.forEach (d) ->
    d.date = parseDate(d.date)

  buildings = color.domain().map (name) ->
    return {
      name: name,
      values: data.map (d) ->
        return {date: d.date, kwh: +d[name]}
    }

  x.domain(d3.extent(data, (d) -> d.date))
  y.domain([
    d3.min buildings, (c) ->
      d3.min(c.values, (v) -> v.kwh)

    d3.max buildings, (c) ->
      d3.max(c.values, (v) -> v.kwh)
  ])

  svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis)

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("KWH")

  building = svg.selectAll(".city").data(buildings).enter().append("g").attr("class", "city")

  building.append("path")
    .attr("class", "line")
    .attr("d", (d) -> line(d.values))
    .style("stroke", (d) -> color(d.name))

  building.append("text")
    .datum((d) -> {name: d.name, value: d.values[d.values.length - 1]})
    .attr("transform", (d) -> "translate(" + x(d.value.date) + "," + y(d.value.kwh) + ")")
    .attr("x", 3)
    .attr("dy", ".35em")
    .text((d) -> d.name)

root.Whizmo.Data.Graph.BarChart = () ->
  margin = {top: 20, right: 20, bottom: 30, left: 80}
  width = 900 - margin.left - margin.right
  height = 300 - margin.top - margin.bottom

  x = d3.scale.ordinal().rangeRoundBands([0, width], .1)

  y = d3.scale.linear().range([height, 0])

  xAxis = d3.svg.axis().scale(x).orient("bottom")

  yAxis = d3.svg.axis().scale(y).orient("left")

  svg = d3.select("#barchart").append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
  .append("g")
    .attr("transform", "translate(" + margin.left + "," + margin.top + ")")

  data = root.Whizmo.Data.barChart

  x.domain(data.map((d) -> d.letter))
  y.domain([0, d3.max(data, (d) -> d.$)])

  svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis)

  svg.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      #.attr("transform", "rotate(-90)")
      .attr("y", -10)
      .attr("x", 70)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("US(Dollars)")

  svg.selectAll(".bar")
      .data(data)
    .enter().append("rect")
      .attr("class", "bar")
      .attr("x", (d) -> x(d.letter))
      .attr("width", x.rangeBand())
      .attr("y", (d) -> y(d.$))
      .attr("height", (d) -> height - y(d.$))

root.Whizmo.Data.Graph.BubbleChart = () ->
  r = 960
  format = d3.format(",d")
  fill = d3.scale.category20c()

  bubble = d3.layout.pack().sort(null).size([r, r]).padding(1.5)
  vis = d3.select("#bubblechart").append("svg")
    .attr("width", r)
    .attr("height", r)
    .attr("class", "bubble")


