module Widgets
  class DashboardWidget
    attr_accessor :title, :panel, :color, :opts, :data, :text, :size

    COLOURS = {
      'primary' => 'primary',
      'green' => 'success',
      'light-blue' => 'info',
      'yellow' => 'warning',
      'red' => 'danger'
    }

    def initialize(title, panel='text', opts = {}, data={})
      self.title = title
      self.data = data
      self.panel = panel

      # Set the custom opts
      self.text = opts[:text] || ''
      panel_colour = opts[:color] || 'primary'
      self.color = COLOURS[panel_colour] || panel_colour
      self.size = opts[:size] || 'medium'

      # Remove the custom opts that are not Morris options
      opts.delete(:size)
      opts.delete(:text)
      opts.delete(:color)
      self.opts = opts
    end

    def add_data_pair(name, value)
      self.data[name] = value
    end

    def remove_data_pair(name, value)
      self.data.delete(name)
    end

  end
end
