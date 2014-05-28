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
    @graph_widget = Widgets::DashboardWidget.new('Ash\'s Journey','bar_graph', { size:'large', color: 'red', text: 'I choose you, Pikachu', pointSize: 5})
  end

  it 'should generate a text panel with no data' do
    @dummy_class.widget(@widget).should eq "<div class='panel panel-primary dashboard-panel medium'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><ul class='list-group'></ul></div></div>"
  end

  it 'should generate a text panel with data' do
    @widget.add_data_pair(:test, 5)
    @widget.add_data_pair(:test2, 6)
    @dummy_class.widget(@widget).should eq "<div class='panel panel-primary dashboard-panel medium'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><ul class='list-group'><li class='list-group-item clearfix'><h4 class='key'>test</h4><h4 class='value'>5</h4></li><li class='list-group-item clearfix'><h4 class='key'>test2</h4><h4 class='value'>6</h4></li></ul></div></div>"
  end

  it 'should generate a bar_graph panel with no data and some options' do
    @dummy_class.widget(@graph_widget).should eq "<div class='panel panel-danger dashboard-panel large'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><div class='panel-body'>I choose you, Pikachu</div><div id='bar_graph-ash-s-journey' class='graph'></div><script>bar_graph([],[],'ash-s-journey',{\"pointSize\":5})</script></div></div>"
  end

  it 'should generate a bar_graph panel with data and options' do
    @graph_widget.add_data_pair(:test, 5)
    @dummy_class.widget(@graph_widget).should eq "<div class='panel panel-danger dashboard-panel large'><div class='panel-heading'><h2 class='panel-title'>Ash's Journey</h2></div><div class='panel-content'><div class='panel-body'>I choose you, Pikachu</div><div id='bar_graph-ash-s-journey' class='graph'></div><script>bar_graph([{\"label\":\"test\",\"value\":5}],[:test],'ash-s-journey',{\"pointSize\":5})</script></div></div>"
  end

end
