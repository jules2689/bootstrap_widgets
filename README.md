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
  DasboardWidget.new(title, panel='text', opts = {}, data={})
  ```

  As you can see, only title is required. Panel Type defaults to text, and opts/data are initialized to {}.

  Currently the available panel types are: "text", "bar_graph", "line_graph", "donut_graph", "area_graph".

  The opts array can take the following custom options:
    - size ~> The size of the widget (small, medium, large, x-large). The default is medium.
    - text ~> The text to be displayed at the top of the widget. The default is nothing. If you set text, the recommended size is large or x-large.
    - color ~> The color of the array. See below for more details.

  On top of the above options, for any graphs, Morris.js options can be passed as a hash array. You can read more about which ones are available [here](http://www.oesmith.co.uk/morris.js/)

  Here is an example hash: ```{ text: 'I want to be the very best', size: 'large', color: 'light-blue', pointFillColors: ["#469ad0"], pointSize: 10, lineWidth: 10 }```

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
