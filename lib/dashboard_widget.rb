module Widgets
  class DashboardWidget
    attr_accessor :title, :panel, :text, :data, :type

    COLOURS = {
      'primary' => 'primary',
      'green' => 'success',
      'light-blue' => 'info',
      'yellow' => 'warning',
      'red' => 'danger'
    }

    def initialize(title, panel='text', text='', data={}, type='primary')
      self.title = title
      self.data = data
      self.text = text
      self.panel = panel
      self.type = COLOURS[type] || type
    end

    def add_data_pair(name, value)
      self.data[name] = value
    end

    def remove_data_pair(name, value)
      self.data.delete(name)
    end

  end
end
