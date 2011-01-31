require 'spec_helper'

describe "entries/index.html.erb" do
  before(:each) do
    assign(:entries, [
      stub_model(Entry,
        :event => Event.new(:name => 'event1'),
        :member => Member.new(:name => 'yamada')
      ),
      stub_model(Entry,
        :event => Event.new(:name => 'event2'),
        :member => Member.new(:name => 'yamada')
      )
    ])
  end

  it "renders a list of entries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 'event1', :count => 1
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 'yamada', :count => 2
  end
end
