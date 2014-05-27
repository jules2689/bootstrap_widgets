#= require chart.min

window.bar_graph = (labels, data, title) ->
  data = {
    labels : labels,
    datasets : [
      {
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        pointColor : "rgba(220,220,220,1)",
        pointStrokeColor : "#fff",
        data : data
      }
    ]
  }
  width = $('#bar-graph-' + title).parent().width()
  $('#bar-graph-' + title).attr('width', width)
  new Chart($('#bar-graph-' + title).get(0).getContext("2d")).Bar(data)

window.line_graph = (labels, data, title) ->
  data = {
    labels : labels,
    datasets : [
      {
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        pointColor : "rgba(220,220,220,1)",
        pointStrokeColor : "#fff",
        data : data
      }
    ]
  }
  width = $('#line-graph-' + title).parent().width()
  $('#line-graph-' + title).attr('width', width)
  new Chart($('#line-graph-' + title).get(0).getContext("2d")).Line(data)
