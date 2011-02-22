# -*- coding: utf-8 -*-
require 'spec_helper'

describe Member do
  before do
    @valid_auth = {
      "provider" => "twitter",
      "uid" => "123456789",
      "user_info" => {
        "nickname" => "nick",
        "name" => "name",
        "description" => "desc",
        "urls" => {
          "Website" => "url"
        }
      }
    }
  end

  context "twitter id のバリデーションチェック" do
    it "必須である" do
      member = Member.new(:name => "name",
                          :address => "address",
                          :email => "email",
                          :blog_url => "blog_url",
                          :birthday => Date.today,
                          :profile => "profile",
                          :uid => "uid",
                          :provider => "provider")
      member.should be_invalid
      member.errors[:twitter_id].should have(1).item
    end

    it "重複しない" do
      one = Member.new(:name => "one", :address => "address1", :email => "email1",
                       :blog_url => "url1", :birthday => 1.years.ago,
                       :profile => "prof1", :uid => "uid1", :provider => "provider1",
                       :twitter_id => "same_id")
      two = Member.new(:name => "two", :address => "address2", :email => "email2",
                       :blog_url => "url2", :birthday => 2.years.ago,
                       :profile => "prof2", :uid => "uid2", :provider => "provider2",
                       :twitter_id => "same_id")
      one.save.should be_true
      two.save.should be_false
      two.errors[:twitter_id].should have(1).item
    end

    it "変更できない" do
      one = Member.create(:name => "one", :address => "address1", :email => "email1",
                          :blog_url => "url1", :birthday => 1.years.ago,
                          :profile => "prof1", :uid => "uid1", :provider => "provider1",
                          :twitter_id => "same_id")
      one.update_attributes(:twitter_id => "another_id").should be_false
      one.errors[:twitter_id].should have(1).item
    end
  end

  it "誕生日は必須" do
    member = Member.new(:name => "name",
                        :address => "address",
                        :email => "email",
                        :blog_url => "blog_url",
                        :twitter_id => "twitter_id",
                        :profile => "profile",
                        :uid => "uid",
                        :provider => "provider")
    member.should be_invalid
    member.errors[:birthday].should have(1).item
  end

  it "#create_by_auth で作成されるユーザには Twitter の情報がセットされている" do
    expect { Member.create_by_auth(@valid_auth) }.to change { Member.count }.by(1)
    nick = Member.find_by_twitter_id("nick")
    nick.should be_valid
    nick.name.should == "name"
    nick.twitter_id.should == "nick"
    nick.profile.should == "desc"
    nick.blog_url.should == "url"
  end

  it "他人のプロフィールは編集できない" do
    me = Member.create(:name => "me", :address => "address1", :email => "email1",
                       :blog_url => "url1", :birthday => 1.years.ago,
                       :profile => "prof1", :uid => "uid1", :provider => "provider1",
                       :twitter_id => "same_id")
    you = Member.create(:name => "you", :address => "address2", :email => "email2",
                        :blog_url => "url2", :birthday => 2.years.ago,
                        :profile => "prof2", :uid => "uid2", :provider => "provider2",
                        :twitter_id => "same_id")
    request.session[:uid] = me.uid
    you.update_attributes(:name => "he").should be_false
    me.errors[:base].should have(1).item
  end

end
