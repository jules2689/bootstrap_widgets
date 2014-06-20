require 'widgets/widget'

class TextWidget < Widget

  def self.text_widget(widget)
    output = header(widget.color, widget.title, widget.row_size, widget.col_size)
    output << widget_text(widget.text)
    output << text_panel(widget.data, widget.direction)
    output << cap
    output.html_safe
  end

  def self.single_text_widget(widget)
    output = single_text_header(widget.col_size, widget.color)
    output << visual(widget.icon)
    output << details(widget.data.keys.first, widget.data.values.first)
    output << view_more(widget.link) unless widget.link.nil?
    output << single_cap
    output.html_safe
  end

private

  def self.text_panel(data={}, direction)
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

  def self.single_text_header(col_size, type)
    output = "<div class=\"panel panel-#{type} item widget-panel single_text small col-#{col_size}\">"
    output << "<div class=\"info\">"
    output
  end

  def self.visual(icon)
    output = "<div class=\"visual\">"
    output << "<i class=\"glyphicon #{icon}\"></i>"
    output << "</div>"
  end

  def self.details(value, title)
    output = "<div class=\"details\"><div class=\"number\">"
    output << value.to_s
    output << "</div><div class=\"desc\">"
    output << title.to_s
    output << "</div></div></div>"
    output
  end

  def self.view_more(link)
    "<a class=\"view-more\" href=\"#{link}\">View more <i class=\"glyphicon glyphicon-expand\"></i></a>"
  end

end
