# -*- coding: utf-8 -*-
require 'spec_helper'

describe Member do
  it "twitter id は必須" do
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

  it "#create で作成されるユーザには既に twitter id がセットされている"

  it "メンバーは自分が参加しているイベントをキャンセルすることができる"
end
