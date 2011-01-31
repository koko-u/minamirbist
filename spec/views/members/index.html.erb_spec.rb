require 'spec_helper'

describe "members/index.html.erb" do
  before(:each) do
    assign(:members, [
      stub_model(Member,
        :name => "Name",
        :address => "Address",
        :email => "Email",
        :twitter_id => "Twitter",
        :blog_url => "Blog Url",
        :profile => "MyText"
      ),
      stub_model(Member,
        :name => "Name",
        :address => "Address",
        :email => "Email",
        :twitter_id => "Twitter",
        :blog_url => "Blog Url",
        :profile => "MyText"
      )
    ])
  end

  it "renders a list of members" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Twitter".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Blog Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
