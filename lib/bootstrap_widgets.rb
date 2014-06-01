require "bootstrap_widgets/version"
require "dashboard_widget"

module BootstrapWidgets
  class Engine < ::Rails::Engine
  end

  def widget_group(widgets, cols=3)
    output = group_header(90/cols)
    widgets.each do |widget|
      output << widget(widget)
    end
    output << single_cap
    output.html_safe
  end

  def widget(widget)
    case widget.panel
    when 'single_text'
      single_text_widget(widget)
    else
      standard_widget(widget)
    end
  end

private

  ### GROUPS & DASHBOARD ###

  def group_header(width)
    output = "<style>.masonry .widget-panel, .masonry .grid-sizer { width: #{width}%; margin-left: 1%;margin-right: 1%; } .widget-panel.col-2 { width: #{(width*2 + 2).to_s}% !important; } .widget-panel.col-3 { width: #{(width*3 + 2*2).to_s}% !important; } .widget-panel.col-4 { width: #{(width*4 + 3*2).to_s}% !important; } .widget-panel.col-5 { width: #{(width*5 + 4*2).to_s}% !important; }</style>"
    output << "<div class='loading-view'><span id=\"widget-spinner\"></span></div>"
    output << "<div class=\"masonry js-masonry\" data-col=\"#{width.to_s}%\" data-masonry-options='{ \"columnWidth\":\".grid-sizer\", \"itemSelector\":\".item\" }'><div class=\"grid-sizer\"></div>"
    output
  end

  ### WIDGETS ###

  def standard_widget(widget)
    output = header(widget.color, widget.title, widget.row_size, widget.col_size)
    output << widget_text(widget.text)
    output << panel_content(widget)
    output << cap
    output.html_safe
  end

  def header(type, title, row_size, col_size)
    output = "<div class='panel panel-#{type} item widget-panel #{row_size} col-#{col_size}'>"
    output << "<div class='panel-heading'><h2 class='panel-title'>#{title}</h2></div>"
    output << "<div class='panel-content'>"
    output
  end

  def widget_text(text)
    output = ""
    unless text.empty?
     output << "<div class='panel-body'>#{text}</div>"
    end
    output
  end

  def panel_content(widget)
    if widget.panel == 'text'
      text_panel(widget.data, widget.direction)
    else
      graph(widget.data, widget.title, widget.panel, widget.labels, widget.opts)
    end
  end

  def text_panel(data={}, direction)
    output = "<ul class='list-group'>"
    data.each do |key, value|
      output << "<li class='list-group-item clearfix'>"
      if direction == 'LTR'
        output << "<h4 class='left-text'>#{key}</h4>"
        output << "<h4 class='right-text'>#{value}</h4>"
      else
        output << "<h4 class='left-text'>#{value}</h4>"
        output << "<h4 class='right-text'>#{key}</h4>"
      end
      output << "</li>"
    end
    output << "</ul>"
    output
  end

  def graph(data={}, title, graph, labels, opts)
    output = "<div id='#{graph}-#{title.parameterize}' class='graph'></div>"
    output << "<script>#{graph}(#{json_data(data)},#{labels},'#{title.parameterize}',#{opts.to_json})</script>"
    output
  end

  def single_cap
    "</div>"
  end

  def cap
    "</div></div>"
  end

  ### SINGLE TEXT WIDGET ###

  def single_text_widget(widget)
    output = single_text_header(widget.col_size, widget.color)
    output << visual(widget.icon)
    output << details(widget.data.keys.first, widget.data.values.first)
    output << view_more(widget.link) unless widget.link.nil?
    output << single_cap
    output.html_safe
  end

  def single_text_header(col_size, type)
    output = "<div class=\"panel panel-#{type} item widget-panel single_text small col-#{col_size}\">"
    output << "<div class=\"info\">"
    output
  end

  def visual(icon)
    output = "<div class=\"visual\">"
    output << "<i class=\"glyphicon #{icon}\"></i>"
    output << "</div>"
  end

  def details(value, title)
    output = "<div class=\"details\"><div class=\"number\">"
    output << value.to_s
    output << "</div><div class=\"desc\">"
    output << title.to_s
    output << "</div></div></div>"
    output
  end

  def view_more(link)
    "<a class=\"view-more\" href=\"#{link}\">View more <i class=\"glyphicon glyphicon-expand\"></i></a>"
  end

  ### HELPERS ###

  def json_data(data={})
    jsdata = []
    data.each {|key, value| jsdata << { label: "#{key}", value: value } }
    jsdata.to_json.html_safe
  end

end
