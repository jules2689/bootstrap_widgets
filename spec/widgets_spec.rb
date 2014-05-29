require 'spec_helper'

describe Widgets do
  class DummyClass
  end

  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(Widgets)
  end

  before do
    @widget = Widgets::DashboardWidget.new('Ash\'s Journey')
    # graph widget overrides the size, color and text
    @graph_widget = Widgets::DashboardWidget.new('Ash\'s Journey','bar_graph', { row_size:'large', color: 'red', text: 'I choose you, Pikachu', pointSize: 5})
  end

  it 'should generate a text panel with no data' do
    @dummy_class.widget(@widget).should eq "<div class='panel panel-primary item dashboard-panel medium col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><ul class='list-group'></ul></div></div>"
  end

  it 'should generate a text panel with data' do
    @widget.add_data_pair(:test, 5)
    @widget.add_data_pair(:test2, 6)
    @dummy_class.widget(@widget).should eq "<div class='panel panel-primary item dashboard-panel medium col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><ul class='list-group'><li class='list-group-item clearfix'><h4 class='key'>test</h4><h4 class='value'>5</h4></li><li class='list-group-item clearfix'><h4 class='key'>test2</h4><h4 class='value'>6</h4></li></ul></div></div>"
  end

  it 'should generate a bar_graph panel with no data and some options' do
    @dummy_class.widget(@graph_widget).should eq "<div class='panel panel-danger item dashboard-panel large col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><div class='panel-body'>I choose you, Pikachu</div><div id='bar_graph-ash-s-journey' class='graph'></div><script>bar_graph([],[],'ash-s-journey',{\"pointSize\":5})</script></div></div>"
  end

  it 'should generate a bar_graph panel with data and options' do
    @graph_widget.add_data_pair(:test, 5)
    @dummy_class.widget(@graph_widget).should eq "<div class='panel panel-danger item dashboard-panel large col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><div class='panel-body'>I choose you, Pikachu</div><div id='bar_graph-ash-s-journey' class='graph'></div><script>bar_graph([{\"label\":\"test\",\"value\":5}],[:test],'ash-s-journey',{\"pointSize\":5})</script></div></div>"
  end

  it 'should assign col class' do
    @graph_widget.col_size = '3'
    @dummy_class.widget(@graph_widget).should eq "<div class='panel panel-danger item dashboard-panel large col-3'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><div class='panel-body'>I choose you, Pikachu</div><div id='bar_graph-ash-s-journey' class='graph'></div><script>bar_graph([],[],'ash-s-journey',{\"pointSize\":5})</script></div></div>"
  end

  it 'should generate a widget_group' do
    @graph_widget.add_data_pair(:test, 5)
    @widget.add_data_pair(:test, 5)
    @widget.add_data_pair(:test2, 6)
    @dummy_class.widget_group([@graph_widget, @widget]).should eq "<style>.masonry .dashboard-panel, .masonry .grid-sizer { width: 30%; margin-left: 1%;margin-right: 1%; } .dashboard-panel.col-2 { width: 62% !important; } .dashboard-panel.col-3 { width: 94% !important; } .dashboard-panel.col-4 { width: 126% !important; } .dashboard-panel.col-5 { width: 158% !important; }</style><div class=\"masonry js-masonry\" data-col=\"30%\" data-masonry-options='{ \"columnWidth\":\".grid-sizer\", \"itemSelector\":\".item\" }'><div class=\"grid-sizer\"></div><div class='panel panel-danger item dashboard-panel large col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><div class='panel-body'>I choose you, Pikachu</div><div id='bar_graph-ash-s-journey' class='graph'></div><script>bar_graph([{\"label\":\"test\",\"value\":5}],[:test],'ash-s-journey',{\"pointSize\":5})</script></div></div><div class='panel panel-primary item dashboard-panel medium col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><ul class='list-group'><li class='list-group-item clearfix'><h4 class='key'>test</h4><h4 class='value'>5</h4></li><li class='list-group-item clearfix'><h4 class='key'>test2</h4><h4 class='value'>6</h4></li></ul></div></div></div>"
    @dummy_class.widget_group([@graph_widget, @widget], 4).should eq "<style>.masonry .dashboard-panel, .masonry .grid-sizer { width: 22%; margin-left: 1%;margin-right: 1%; } .dashboard-panel.col-2 { width: 46% !important; } .dashboard-panel.col-3 { width: 70% !important; } .dashboard-panel.col-4 { width: 94% !important; } .dashboard-panel.col-5 { width: 118% !important; }</style><div class=\"masonry js-masonry\" data-col=\"22%\" data-masonry-options='{ \"columnWidth\":\".grid-sizer\", \"itemSelector\":\".item\" }'><div class=\"grid-sizer\"></div><div class='panel panel-danger item dashboard-panel large col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><div class='panel-body'>I choose you, Pikachu</div><div id='bar_graph-ash-s-journey' class='graph'></div><script>bar_graph([{\"label\":\"test\",\"value\":5}],[:test],'ash-s-journey',{\"pointSize\":5})</script></div></div><div class='panel panel-primary item dashboard-panel medium col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><ul class='list-group'><li class='list-group-item clearfix'><h4 class='key'>test</h4><h4 class='value'>5</h4></li><li class='list-group-item clearfix'><h4 class='key'>test2</h4><h4 class='value'>6</h4></li></ul></div></div></div>"
  end

end
