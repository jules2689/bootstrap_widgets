# Widgets

A simplistic way of rendering dashboard widgets with Bootstrap.

## Setup

Add this line to your application's Gemfile:

    gem 'widgets'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install widgets

Require the CSS file in application.css

   ```
   //= require widgets
   ```

Require the JS file in application.js

  ```
  //= require widgets
  ```

Include the Widgets Module in your Application Helper:

  ```Ruby
  module ApplicationHelper
    include Widgets
  end
  ```

Then in your erb views just call the Helper:

  ```Ruby
  <%= widget @some_dashboard_widget %>
  ```

## Dashboard Widgets

A Dashboard Widget can be created by calling:

  ```Ruby
  DasboardWidget.new(title, type='text', text='', data={}, type='primary')
  ```

  As you can see, only title is required. Type defaults to text, text is optional, data is initializes to {}, and the type is initialized to primary.

  Currently the available types are: "text", "bar_graph", "line_graph", "donut_graph", "area_graph".

The following helper methods are available to handle data:

  ```Ruby
  widget.add_data_pair(key,value)
  widget.remove_data_pair(key, value)
  ```

### Panel Colours

Each of Bootstrap's main colours have been mapped to a type that may make more sense. These are listed below, however, you may use the default Bootstrap names.

   ```Ruby
   'primary' => 'primary',
   'green' => 'success',
   'light-blue' => 'info',
   'yellow' => 'warning',
   'red' => 'danger'
   ```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/bootstrap-widget/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
