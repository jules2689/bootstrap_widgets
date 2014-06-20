require 'widgets/widget'

class GraphWidget < Widget

  def self.graph_widget(widget)
    output = header(widget.color, widget.title, widget.row_size, widget.col_size)
    output << widget_text(widget.text)
    output << panel_content(widget)
    output << cap
    output.html_safe
  end

  def self.graph(data={}, title, graph, labels, opts)
    output = "<div id='#{graph}-#{title.parameterize}' class='graph'></div>"
    output << "<script>#{graph}(#{json_data(data)},#{labels},'#{title.parameterize}',#{opts.to_json})</script>"
    output
  end

end
