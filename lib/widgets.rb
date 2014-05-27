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
    output << list_group(widget.data)
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

  def list_group(data={})
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

  def cap
    output = "</div></div>"
    return output
  end

end
