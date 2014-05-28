require 'spec_helper'

describe Widgets::DashboardWidget do
  before do
    @widget = Widgets::DashboardWidget.new('Ash\'s Journey')
    @graph_widget = Widgets::DashboardWidget.new('Ash\'s Journey','bar_graph', { size:'large', color: 'red', text: 'I choose you, Pikachu', pointSize: 5})
  end

  it 'should have a title' do
    @widget.title.should eq 'Ash\'s Journey'
    @graph_widget.title.should eq 'Ash\'s Journey'
  end

  it 'should have a panel type' do
    @widget.panel.should eq 'text'
    @graph_widget.panel.should eq 'bar_graph'
  end

  it 'should have a color' do
    @widget.color.should eq 'primary'
    @graph_widget.color.should eq 'danger' #red is translated to danger
  end

  it 'should have a size' do
    @widget.size.should eq 'medium'
    @graph_widget.size.should eq 'large'
  end

  it 'should have text' do
    @widget.text.should eq ''
    @graph_widget.text.should eq 'I choose you, Pikachu'
  end

  it 'should have opts' do
    expect(@widget.opts).to be_empty
    expect(@graph_widget.opts).to have_key(:pointSize)
  end

  it 'should have no data' do
    expect(@widget.data).to be_empty
    expect(@graph_widget.data).to be_empty
  end

  it 'should have data after adding' do
    @widget.add_data_pair(:test, 5)
    expect(@widget.data).not_to be_empty
    expect(@widget.data).to have_key(:test)
  end

  it 'should not have data after deleting' do
    @widget.add_data_pair(:test, 5)
    expect(@widget.data).not_to be_empty
    @widget.remove_data_pair(:test)
    expect(@widget.data).to be_empty
  end

end
