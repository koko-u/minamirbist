# -*- coding: utf-8 -*-
require 'spec_helper'

describe SessionsController do

  describe "GET 'create'" do
    it "should be successful" do
      get 'create'
      response.should be_success
    end
  end

  it "メンバー登録されていないユーザでログオンすると、メンバー編集画面に遷移する"
  it "メンバー編集画面にログインした twitter id を渡す"

end
