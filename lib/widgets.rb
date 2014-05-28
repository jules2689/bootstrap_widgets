require "widgets/version"
require "dashboard_widget.rb"

module Widgets
  module Rails
    class Engine < ::Rails::Engine
    end
  end

  def widget_group(widgets)
    output = group_header
    widgets.each do |widget|
      output << widget(widget)
    end
    output << group_cap
    return output.html_safe
  end

  def widget(widget)
    output = header(widget.color, widget.title, widget.size)
    output << widget_text(widget.text)
    output << panel_content(widget.data, widget.panel, widget.title, widget.opts)
    output << cap
    return output.html_safe
  end

private

  def group_header
    return "<div class='js-masonry' id='masonry-container' data-masonry-options=\"{ 'itemSelector': '.dashboard-panel', 'columnWidth': '.gridsizer' }\"><div class='gridsizer'></div>"
  end

  def group_cap
    return "</div>"
  end

  def header(type, title, size)
    output = "<div class='panel panel-#{type} dashboard-panel #{size}'>"
    output << "<div class='panel-heading'><h2 class='panel-title'>#{title}</h2></div>"
    output << "<div class='panel-content'>"
    return output
  end

  def widget_text(text)
    output = ""
    unless text.empty?
     output << "<div class='panel-body'>#{text}</div>"
    end
    return output
  end

  def panel_content(data={}, panel_type, title, opts)
    if panel_type == 'text'
      return text_panel(data)
    else
      return graph(data, title, panel_type, opts)
    end
  end

  def text_panel(data={})
    output = "<ul class='list-group'>"
    data.each do |key, value|
      output << "<li class='list-group-item clearfix'>"
      output << "<h4 class='key'>#{key}</h4>"
      output << "<h4 class='value'>#{value}</h4>"
      output << "</li>"
    end
    output << "</ul>"
    return output
  end

  def graph(data={}, title, graph, opts)
    output = "<div id='#{graph}-#{title.parameterize}' class='graph'></div>"
    output << "<script>#{graph}(#{json_data(data)},#{data.keys},'#{title.parameterize}',#{opts.to_json})</script>"
    return output
  end

  def cap
    output = "</div></div>"
    return output
  end

  def json_data(data={})
    jsdata = []
    data.each {|key, value| jsdata << { label: "#{key}", value: value } }
    return jsdata.to_json.html_safe
  end

end
