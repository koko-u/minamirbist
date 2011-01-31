require 'spec_helper'

describe "members/new.html.erb" do
  before(:each) do
    assign(:member, stub_model(Member,
      :name => "MyString",
      :address => "MyString",
      :email => "MyString",
      :twitter_id => "MyString",
      :blog_url => "MyString",
      :profile => "MyText"
    ).as_new_record)
  end

  it "renders new member form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => members_path, :method => "post" do
      assert_select "input#member_name", :name => "member[name]"
      assert_select "input#member_address", :name => "member[address]"
      assert_select "input#member_email", :name => "member[email]"
      assert_select "input#member_twitter_id", :name => "member[twitter_id]"
      assert_select "input#member_blog_url", :name => "member[blog_url]"
      assert_select "textarea#member_profile", :name => "member[profile]"
    end
  end
end
