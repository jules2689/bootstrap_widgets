module BootstrapWidgets
  class DashboardWidget
    attr_accessor :title, :panel, :color, :opts, :data, :text, :row_size, :col_size,
                  :icon, :link, :labels, :direction

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
      self.row_size = opts[:row_size] || 'medium'
      self.col_size = opts[:col_size] || '1'
      self.icon = opts[:icon] || 'glyphicon-plus'
      self.link = opts[:link] || nil
      self.labels = opts[:labels] || ['']
      self.direction = opts[:direction] || 'LTR'

      # Remove the custom opts that are not Morris options
      opts.delete(:row_size)
      opts.delete(:col_size)
      opts.delete(:text)
      opts.delete(:color)
      opts.delete(:icon)
      opts.delete(:link)
      opts.delete(:labels)
      opts.delete(:direction)

      self.opts = opts
    end

    def add_data_pair(name, value)
      self.data[name] = value
    end

    def remove_data_pair(name)
      self.data.delete(name)
    end

  end
end
