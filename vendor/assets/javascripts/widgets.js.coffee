#= require raphael.min
#= require morris.min
#= require masonry

window.graphs = []

window.bar_graph = (json_data, labels, title, opts) ->
  options = $.extend({},opts,{
    element: 'bar_graph-' + title,
    data:  json_data,
    xkey: 'label',
    ykeys: ['value'],
    labels: labels,
    xLabelMargin: 10,
    resize: true
  })
  graph = new Morris.Bar options
  window.graphs.push graph

window.line_graph = (json_data, labels, title, opts) ->
  options = $.extend({},opts,{
    element: 'line_graph-' + title,
    parseTime: false,
    data:  json_data,
    xkey: 'label',
    ykeys: ['value'],
    labels: labels,
    resize: true
  })
  graph = new Morris.Line options
  window.graphs.push graph

window.area_graph = (json_data, labels, title, opts) ->
  options = $.extend({},opts,{
    element: 'area_graph-' + title,
    parseTime: false,
    data:  json_data,
    xkey: 'label',
    ykeys: ['value'],
    labels: labels,
    resize: true
  })
  graph = new Morris.Area options
  window.graphs.push graph

window.donut_graph = (json_data, labels, title, opts) ->
  options = $.extend({},opts,{
    element: 'donut_graph-' + title,
    parseTime: false,
    data:  json_data,
    resize: true
  })
  graph = new Morris.Donut options
  window.graphs.push graph

$( window ).resize ->
  redraw(i) for i in [0..window.graphs.length-1]

window.redraw = (idx) ->
  graph = window.graphs[idx]
  graph.redraw()

$(document).on "ready page:change", ->
  if $('.masonry').length
    container = document.querySelector('.masonry');
    msnry = new Masonry container
