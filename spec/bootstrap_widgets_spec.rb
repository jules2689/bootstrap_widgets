require 'spec_helper'

describe BootstrapWidgets do
  class DummyClass
  end

  before(:each) do
    @dummy_class = DummyClass.new
    @dummy_class.extend(BootstrapWidgets)
  end

  before do
    @widget = BootstrapWidgets::DashboardWidget.new('Ash\'s Journey')
    # graph widget overrides the size, color and text
    @graph_widget = BootstrapWidgets::DashboardWidget.new('Ash\'s Journey','bar_graph', { row_size:'large', color: 'red', text: 'I choose you, Pikachu', pointSize: 5})

    @single_text = BootstrapWidgets::DashboardWidget.new('', 'single_text', { icon: 'glyphicon-user' }, { name: 'name-test' })
  end

  it 'should generate a text panel with no data' do
    @dummy_class.widget(@widget).should eq "<div class='panel panel-primary item widget-panel medium col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><ul class='list-group'></ul></div></div>"
  end

  it 'should generate a single text panel' do
    @dummy_class.widget(@single_text).should eq "<div class=\"panel panel-primary item widget-panel single_text small col-1\"><div class=\"info\"><div class=\"visual\"><i class=\"glyphicon glyphicon-user\"></i></div><div class=\"details\"><div class=\"number\">name</div><div class=\"desc\">name-test</div></div></div></div>"
  end

  it 'should generate a text panel with data' do
    @widget.add_data_pair(:test, 5)
    @widget.add_data_pair(:test2, 6)
    @dummy_class.widget(@widget).should eq "<div class='panel panel-primary item widget-panel medium col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><ul class='list-group'><li class='list-group-item clearfix'><h4 class='left-text'>test</h4><h4 class='right-text'>5</h4></li><li class='list-group-item clearfix'><h4 class='left-text'>test2</h4><h4 class='right-text'>6</h4></li></ul></div></div>"
  end

  it 'should generate a bar_graph panel with no data and some options' do
    @dummy_class.widget(@graph_widget).should eq "<div class='panel panel-danger item widget-panel large col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><div class='panel-body'>I choose you, Pikachu</div><div id='bar_graph-ash-s-journey' class='graph'></div><script>bar_graph([],[\"\"],'ash-s-journey',{\"pointSize\":5})</script></div></div>"
  end

  it 'should generate a bar_graph panel with data and options' do
    @graph_widget.add_data_pair(:test, 5)
    @dummy_class.widget(@graph_widget).should eq "<div class='panel panel-danger item widget-panel large col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><div class='panel-body'>I choose you, Pikachu</div><div id='bar_graph-ash-s-journey' class='graph'></div><script>bar_graph([{\"label\":\"test\",\"value\":5}],[\"\"],'ash-s-journey',{\"pointSize\":5})</script></div></div>"
  end

  it 'should assign col class' do
    @graph_widget.col_size = '3'
    @dummy_class.widget(@graph_widget).should eq "<div class='panel panel-danger item widget-panel large col-3'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><div class='panel-body'>I choose you, Pikachu</div><div id='bar_graph-ash-s-journey' class='graph'></div><script>bar_graph([],[\"\"],'ash-s-journey',{\"pointSize\":5})</script></div></div>"
  end

  it 'should generate a widget_group' do
    @graph_widget.add_data_pair(:test, 5)
    @widget.add_data_pair(:test, 5)
    @widget.add_data_pair(:test2, 6)
    @dummy_class.widget_group([@graph_widget, @widget]).should eq "<style>.masonry .widget-panel, .masonry .grid-sizer { width: 30%; margin-left: 1%;margin-right: 1%; } .widget-panel.col-2 { width: 62% !important; } .widget-panel.col-3 { width: 94% !important; } .widget-panel.col-4 { width: 126% !important; } .widget-panel.col-5 { width: 158% !important; }</style><div class='loading-view'><span id=\"widget-spinner\"></span></div><div class=\"masonry js-masonry\" data-col=\"30%\" data-masonry-options='{ \"columnWidth\":\".grid-sizer\", \"itemSelector\":\".item\" }'><div class=\"grid-sizer\"></div><div class='panel panel-danger item widget-panel large col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><div class='panel-body'>I choose you, Pikachu</div><div id='bar_graph-ash-s-journey' class='graph'></div><script>bar_graph([{\"label\":\"test\",\"value\":5}],[\"\"],'ash-s-journey',{\"pointSize\":5})</script></div></div><div class='panel panel-primary item widget-panel medium col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><ul class='list-group'><li class='list-group-item clearfix'><h4 class='left-text'>test</h4><h4 class='right-text'>5</h4></li><li class='list-group-item clearfix'><h4 class='left-text'>test2</h4><h4 class='right-text'>6</h4></li></ul></div></div></div>"
    @dummy_class.widget_group([@graph_widget, @widget], 4).should eq "<style>.masonry .widget-panel, .masonry .grid-sizer { width: 22%; margin-left: 1%;margin-right: 1%; } .widget-panel.col-2 { width: 46% !important; } .widget-panel.col-3 { width: 70% !important; } .widget-panel.col-4 { width: 94% !important; } .widget-panel.col-5 { width: 118% !important; }</style><div class='loading-view'><span id=\"widget-spinner\"></span></div><div class=\"masonry js-masonry\" data-col=\"22%\" data-masonry-options='{ \"columnWidth\":\".grid-sizer\", \"itemSelector\":\".item\" }'><div class=\"grid-sizer\"></div><div class='panel panel-danger item widget-panel large col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><div class='panel-body'>I choose you, Pikachu</div><div id='bar_graph-ash-s-journey' class='graph'></div><script>bar_graph([{\"label\":\"test\",\"value\":5}],[\"\"],'ash-s-journey',{\"pointSize\":5})</script></div></div><div class='panel panel-primary item widget-panel medium col-1'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><ul class='list-group'><li class='list-group-item clearfix'><h4 class='left-text'>test</h4><h4 class='right-text'>5</h4></li><li class='list-group-item clearfix'><h4 class='left-text'>test2</h4><h4 class='right-text'>6</h4></li></ul></div></div></div>"
  end

end
