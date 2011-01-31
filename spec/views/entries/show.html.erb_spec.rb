require 'spec_helper'

describe "entries/show.html.erb" do
  before(:each) do
    @entry = assign(:entry, stub_model(Entry,
      :event => nil,
      :member => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
