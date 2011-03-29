# -*- coding: utf-8 -*-
require "spec_helper"

describe EventsController do
  describe "routing" do

    it "put /events/:id/join で該当のイベントに参加" do
      { :put => '/events/1/join' }.should route_to(:controller => "events", :action => "join", :id => "1")
    end
    it "get /events/:id/for_organizer で主催者用のイベント詳細画面" do
      { :get => '/events/1/for_organizer' }.should route_to(:controller => "events", :action => "for_organizer", :id => "1")
    end
    it "put /events/:id/cancel でイベントの参加をキャンセル" do
      { :put => '/events/1/cancel' }.should route_to(:controller => "events", :action => "cancel", :id => "1")
    end
    it "get /events で一覧表示" do
      { :get => '/events' }.should route_to(:controller => "events", :action => "index")
    end
    it "get /events/new で新規登録" do
      { :get => "/events/new" }.should route_to(:controller => "events", :action => "new")
    end
    it "post /events で新規登録" do
      { :post => '/events' }.should route_to(:controller => "events", :action => "create")
    end

    it "get /events/:id で詳細画面" do
      { :get => "/events/1" }.should route_to(:controller => "events", :action => "show", :id => "1")
    end

    it "get /events/:id/edit で編集画面" do
      { :get => "/events/1/edit" }.should route_to(:controller => "events", :action => "edit", :id => "1")
    end

    it "put /events/:id で編集" do
      { :put => "/events/1" }.should route_to(:controller => "events", :action => "update", :id => "1")
    end

    it "delete /events/:id で削除" do
      { :delete => "/events/1" }.should route_to(:controller => "events", :action => "destroy", :id => "1")
    end

  end
end
