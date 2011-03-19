# -*- coding: utf-8 -*-
require 'spec_helper'

describe ApplicationController do
  before do 
    @kato = Factory.create(:member, :name => 'kato')
    login_as(@kato)
  end
  it "#current_member でログインしているメンバーの情報が得られる" do 
    subject.send(:current_member).should == @kato
  end
  it "ログアウトすると #current_member は nil となる" do 
    logout
    subject.send(:current_member).should be_nil
  end
end
