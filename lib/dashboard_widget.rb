module Widgets
  class DashboardWidget
    attr_accessor :title, :data, :type, :text

    COLOURS = {
      'primary' => 'primary',
      'green' => 'success',
      'light-blue' => 'info',
      'yellow' => 'warning',
      'red' => 'danger'
    }

    def initialize(title, text='', data={}, type='primary')
      self.title = title
      self.data = data
      self.text = text
      self.type = COLOURS[type]
    end

    def add_data_pair(name, value)
      self.data[name] = value
    end

    def remove_data_pair(name, value)
      self.data.delete(name)
    end

  end
end
