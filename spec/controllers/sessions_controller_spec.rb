# -*- coding: utf-8 -*-
require 'spec_helper'

describe SessionsController do

  describe "GET index" do 
    subject { get :index }
    it { should be_success }
    it { should render_template('index') }
  end

  describe "GET 'create'" do
    before do
      request.env["omniauth.auth"] = {
        "uid" => "u",
        "provider" => "t",
        "user_info" => {
          "name" => "n",
          "nickname" => "k",
          "description" => "d",
          "urls" => {
            "Website" => "u"
          }
        }
      }
    end

    context "既にメンバー登録されているユーザからのログインの場合" do 
      before do 
        @known_user = Factory.build(:member, :name => 'registored')
        Member.expects(:find_by_uid_and_provider).with('u', 't').returns(@known_user)
        get :create, :provider => 'twitter'
      end
      it { session[:uid].should == 'u' }
      it { session[:member].should be_nil }
      it { response.should redirect_to events_path }
    end

    context "新規メンバーからのログインの場合" do 
      before do
        Timecop.freeze(Date.parse('2011-03-10'))
        Member.expects(:find_by_uid_and_provider).with('u', 't').returns(nil)
        get :create, :provider => 'twitter'
      end
      after do 
        Timecop.return
      end
      it { session[:uid].should == 'u' }
      it { 
        session[:member][:name].should == 'n'
        session[:member][:twitter_id].should == 'k'
        session[:member][:profile].should == 'd'
        session[:member][:blog_url].should == 'u'
        session[:member][:provider].should == 't'
        session[:member][:birthday].should == Date.parse('2011-03-10')
      }
      it { response.should redirect_to new_member_path }
    end

  end

  describe "GET failure" do
    subject { get :failure }
    it { should redirect_to root_path }
  end

  describe "GET signout" do 
    subject { get :destroy }
    it { session[:uid].should be_nil }
    it { should redirect_to root_path }
  end
end
