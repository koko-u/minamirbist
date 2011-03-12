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
  context "#create_by_auth の動作" do 
    it "omniauth.auth 環境変数によって「正常な」Member が作成される" do 
      Member.create_by_auth(@valid_auth).should be_valid
    end
    it "omniauth.auth 環境変数によって与えられた値が Member オブジェクトにセットされる" do 
      birth = Date.parse('2011-12-10')
      Timecop.freeze(birth)
      member = Member.create_by_auth(@valid_auth)
      member.name.should == 'name'
      member.address.should be_nil
      member.email.should be_nil
      member.twitter_id.should == 'nick'
      member.blog_url.should == 'url'
      member.birthday.to_s(:db).should == birth.to_s(:db)
      member.profile.should == 'desc'
      member.uid.should == '123456789'
      member.provider.should == 'twitter'
      Timecop.return
    end
  end
  context "twitter id のバリデーションチェック" do
    it "必須である" do
      member = Factory.build(:member, :twitter_id => nil)
      member.should be_invalid
      member.errors[:twitter_id].should have(1).item
    end

    it "重複しない" do
      one = Factory.build(:member, :twitter_id => 'a')
      two = Factory.build(:member, :twitter_id => 'a')
      one.save.should be_true
      two.save.should be_false
      two.errors[:twitter_id].should have(1).item
    end

    it "変更できない" do
      one = Factory.create(:member, :twitter_id => 'an_id')
      one.update_attributes(:twitter_id => "another_id").should be_false
      one.errors[:twitter_id].should have(1).item
    end
  end

  it "誕生日は必須" do
    member = Factory.build(:member, :birthday => nil)
    member.should be_invalid
    member.errors[:birthday].should have(1).item
  end

  it "他人のプロフィールは編集できない" do
    login_member   = Factory.create(:member, :name => 'kozaki')
    another_member = Factory.create(:member, :name => 'watabe')
    ApplicationController.stub(:current_member).and_return(login_member)
    another_member.update_attributes(:profile => "yahoooo!").should be_false
    login_member.errors[:base].should have(1).item
  end

end
