require 'spec_helper'

describe "entries/edit.html.erb" do
  before(:each) do
    @entry = assign(:entry, stub_model(Entry,
      :event => nil,
      :member => nil
    ))
  end

  it "renders the edit entry form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => entry_path(@entry), :method => "post" do
      assert_select "input#entry_event", :name => "entry[event]"
      assert_select "input#entry_member", :name => "entry[member]"
    end
  end
end
