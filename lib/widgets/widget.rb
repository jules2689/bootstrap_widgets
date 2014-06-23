class Widget

protected

  def self.panel_content(widget)
    if widget.panel == 'text'
      text_panel(widget.data, widget.direction)
    else
      graph(widget.data, widget.title, widget.panel, widget.labels, widget.opts)
    end
  end

  def self.header(type, title, row_size, col_size)
    output = "<div class='panel panel-#{type} item widget-panel #{row_size} col-#{col_size}'>"
    output << "<div class='panel-heading'><h2 class='panel-title'>#{title}</h2></div>"
    output << "<div class='panel-content'>"
    output
  end

  def self.widget_text(text)
    output = ""
    unless text.empty?
     output << "<div class='panel-body'>#{text}</div>"
    end
    output
  end

  def self.single_cap
    "</div>"
  end

  def self.cap
    "</div></div>"
  end

  ### HELPERS ###

  def self.json_data(data={})
    jsdata = []
    data.each do |key, value|
      if value.is_a? Hash
        jsdata << { label: "#{key}", value: value[:data] }
      else
        jsdata << { label: "#{key}", value: value }
      end
    end
    jsdata.to_json.html_safe
  end

  def self.link_data(data={})
    jsdata = []
    data.each do |key, value|
      if value.is_a? Hash
        jsdata << value[:link]
      end
    end
    jsdata.to_json.html_safe
  end

end
