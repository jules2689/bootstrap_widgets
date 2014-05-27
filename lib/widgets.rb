require "widgets/version"
require "dashboard_widget.rb"

module Widgets
  module Rails
    class Engine < ::Rails::Engine
    end
  end

  def widget(widget)
    output = header(widget.type, widget.title)
    output << widget_text(widget.text)
    output << panel_content(widget.data, widget.panel, widget.title)
    output << cap
    return output.html_safe
  end

private

  def header(type, title)
    output = "<div class='panel panel-#{type} dashboard-panel'>"
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

  def panel_content(data={}, panel_type, title)
    case panel_type
    when 'text'
      return text_panel(data)
    else
      return graph(data, title, panel_type)
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

  def graph(data={},title,graph)
    output = "<div id='#{graph}-#{title.parameterize}' class='graph'></div>"
    output << "<script>#{graph}(#{json_data(data)},#{data.keys},'#{title.parameterize}')</script>"
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
