#= require raphael.min
#= require morris.min

window.graphs = []

window.bar_graph = (json_data, labels, title) ->
  graph = new Morris.Bar {
    element: 'bar_graph-' + title,
    data:  json_data,
    xkey: 'label',
    ykeys: ['value'],
    labels: labels,
    xLabelMargin: 10,
    resize: true
  }
  window.graphs.push graph

window.line_graph = (json_data, labels, title) ->
  graph = new Morris.Line {
    element: 'line_graph-' + title,
    parseTime: false,
    data:  json_data,
    xkey: 'label',
    ykeys: ['value'],
    labels: labels,
    resize: true
  }
  window.graphs.push graph

window.area_graph = (json_data, labels, title) ->
  graph = new Morris.Area {
    element: 'area_graph-' + title,
    parseTime: false,
    data:  json_data,
    xkey: 'label',
    ykeys: ['value'],
    labels: labels,
    resize: true
  }
  window.graphs.push graph

window.donut_graph = (json_data, labels, title) ->
  graph = new Morris.Donut {
    element: 'donut_graph-' + title,
    parseTime: false,
    data:  json_data,
    resize: true
  }
  window.graphs.push graph

$( window ).resize ->
  redraw(i) for i in [0..window.graphs.length-1]

window.redraw = (idx) ->
  graph = window.graphs[idx]
  graph.redraw()
