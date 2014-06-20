require "bootstrap_widgets/version"
require "dashboard_widget"

require 'widgets/text_widget'
require 'widgets/graph_widget'

module BootstrapWidgets
  class Engine < ::Rails::Engine
  end

  def widget(widget)
    case widget.panel
    when 'single_text'
      TextWidget.single_text_widget(widget)
    when 'text'
      TextWidget.text_widget(widget)
    when 'bar_graph', 'line_graph', 'line_graph', 'donut_graph', 'area_graph'
      GraphWidget.graph_widget(widget)
    end
  end

  def widget_group(widgets, cols=3)
    output = group_header(90/cols)
    widgets.each do |widget|
      output << widget(widget)
    end
    output << "</div>"
    output.html_safe
  end

private

  def group_header(width)
    output = "<style>.masonry .widget-panel, .masonry .grid-sizer { width: #{width}%; margin-left: 1%;margin-right: 1%; } .widget-panel.col-2 { width: #{(width*2 + 2).to_s}% !important; } .widget-panel.col-3 { width: #{(width*3 + 2*2).to_s}% !important; } .widget-panel.col-4 { width: #{(width*4 + 3*2).to_s}% !important; } .widget-panel.col-5 { width: #{(width*5 + 4*2).to_s}% !important; }</style>"
    output << "<div class='loading-view'><span id=\"widget-spinner\"></span></div>"
    output << "<div class=\"masonry js-masonry\" data-col=\"#{width.to_s}%\" data-masonry-options='{ \"columnWidth\":\".grid-sizer\", \"itemSelector\":\".item\" }'><div class=\"grid-sizer\"></div>"
    output
  end

end
