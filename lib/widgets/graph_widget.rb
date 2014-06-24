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
    json_data = json_data(data)
    link_data = link_data(data)
    extra_classes = link_data.size > 0 ? "clickable_graph" : ""

    output = "<div id='#{graph}-#{title.parameterize}' class='graph #{extra_classes}'></div>"
    output << "<script>#{graph}(#{json_data},#{labels},'#{title.parameterize}',#{opts.to_json}, #{link_data.to_json.html_safe})</script>"
    output
  end

end
