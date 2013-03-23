var url = '/weight_measurements.json';
d3.json( url, function( error, data ) {
  console.log( data );

  var parseDate = d3.time.format.iso.parse;

  data.forEach(function(d) {
    d.created_at = parseDate(d.created_at);
    d.value = +d.value;
  });

  var margin = {top: 20, right: 20, bottom: 30, left: 50},
      width = 500 - margin.left - margin.right,
      height = 300 - margin.top - margin.bottom;


  var x = d3.time.scale()
      .range([0, width]);

  var y = d3.scale.linear()
      .range([height, 0]);

  var xAxis = d3.svg.axis()
      .scale(x)
      .orient("bottom");

  var yAxis = d3.svg.axis()
      .scale(y)
      .orient("left");

  var line = d3.svg.line()
      .x(function(d) { return x(d.created_at); })
      .y(function(d) { return y(d.value); });

  var svg = d3.select("#chart").append("svg")
      .attr("width", width + margin.left + margin.right)
      .attr("height", height + margin.top + margin.bottom)
    .append("g")
      .attr("transform", "translate(" + margin.left + "," + margin.top + ")");


    x.domain(d3.extent(data, function(d) { return d.created_at; }));
    y.domain(d3.extent(data, function(d) { return d.value; }));

    svg.append("g")
        .attr("class", "x axis")
        .attr("transform", "translate(0," + height + ")")
        .call(xAxis);

    svg.append("g")
        .attr("class", "y axis")
        .call(yAxis)
      .append("text")
        .attr("transform", "rotate(-90)")
        .attr("y", 6)
        .attr("dy", ".71em")
        .style("text-anchor", "end")
        .text("Weight");

    svg.append("path")
        .datum(data)
        .attr("class", "line")
        .attr("d", line);
});
