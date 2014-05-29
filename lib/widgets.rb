require "widgets/version"
require "dashboard_widget.rb"

module Widgets
  module Rails
    class Engine < ::Rails::Engine
    end
  end

  def widget_group(widgets, cols=3)
    output = group_header(90/cols)
    widgets.each do |widget|
      output << widget(widget)
    end
    output << group_cap
    return output.html_safe
  end

  def widget(widget)
    output = header(widget.color, widget.title, widget.row_size, widget.col_size)
    output << widget_text(widget.text)
    output << panel_content(widget.data, widget.panel, widget.title, widget.opts)
    output << cap
    return output.html_safe
  end

private

  def group_header(width)
    output = "<style>.masonry .dashboard-panel, .masonry .grid-sizer { width: #{width}%; margin-left: 1%;margin-right: 1%; } .dashboard-panel.col-2 { width: #{(width*2 + 2).to_s}% !important; } .dashboard-panel.col-3 { width: #{(width*3 + 2*2).to_s}% !important; } .dashboard-panel.col-4 { width: #{(width*4 + 3*2).to_s}% !important; } .dashboard-panel.col-5 { width: #{(width*5 + 4*2).to_s}% !important; }</style>"
    output << "<div class=\"masonry js-masonry\" data-col=\"#{width.to_s}%\" data-masonry-options='{ \"columnWidth\":\".grid-sizer\", \"itemSelector\":\".item\" }'><div class=\"grid-sizer\"></div>"
    return output
  end

  def group_cap
    return "</div>"
  end

  def header(type, title, row_size, col_size)
    output = "<div class='panel panel-#{type} item dashboard-panel #{row_size} col-#{col_size}'>"
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
