var url = '/weight_measurements.json';
d3.json( url, function( error, data ) {
  console.log( data );
    // do all actions required now that the data is retrieved

  //Width and height
  var w = 500;
  var h = 100;
  var barPadding = 1;
  var dataset = data
  
  //Create SVG element
  var svg = d3.select("body")
        .append("svg")
        .attr("width", w)
        .attr("height", h);

  svg.selectAll("rect")
     .data(dataset)
     .enter()
     .append("rect")
     .attr("x", function(d, i) {
        return i * (w / dataset.length);
     })
     .attr("y", function(d) {
        return h - (d.value / 4);
     })
     .attr("width", w / dataset.length - barPadding)
     .attr("height", function(d) {
        return d.value / 4;
     });    
});
