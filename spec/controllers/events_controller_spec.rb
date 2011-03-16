# -*- coding: utf-8 -*-
require 'spec_helper'

describe EventsController do
  before do
    @kato = Factory.create(:member, :name => 'kato')
    @event = Factory.build(:event, :name => 'just for fun')
    login_as(@kato)
  end

  def mock_event(stubs={})
    @mock_event ||= mock_model(Event, stubs).as_null_object
  end

  describe "GET index" do
    it "@events からすべての event が得られる" do
      Event.expects(:all).returns([@event])
      get :index
      assigns(:events).should == [@event]
    end
  end

  describe "GET show" do
    it "@event に必要となる event 情報が含まれている" do
      Event.expects(:find).with("37").returns(@event)
      get :show, :id => "37"
      assigns(:event).should == @event
    end
  end

  describe "GET new" do
    it "新規に作成した event は ログインユーザがその主催者となる" do
      get :new
      assigns(:event).organizer.should == @kato
    end
  end

  describe "GET edit" do
    it "assigns the requested event as @event" do
      Event.expects(:find).with("37").returns(@event)
      get :edit, :id => "37"
      assigns(:event).should == @event
    end
  end

  describe "PUT cancel_event" do 
    it "参加しているイベントに対してキャンセルできる" do
      Event.stubs(:find).with("10").returns(@event)
      @event.expects(:cancel).with(@kato)
      put :cancel, :id => "10"
    end
    it "キャンセルしたら、/profile ページにリダイレクト"  do
      Event.stubs(:find).with("10").returns(@event)
      @event.expects(:cancel).with(@kato)
      (put :cancel, :id => "10").should redirect_to(profile_path)
    end
  end

  ## PENDING ...
  pending do
  describe "POST create" do
    describe "with valid params" do
      it "assigns a newly created event as @event" do
        login_as(@kato)
        post :create, :event => @event
        assigns(:event).should == @event
      end

      it "redirects to the created event" do
        login_as(@kato)
        post :create, :event => @event
        response.should redirect_to(event_path(@event))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved event as @event" do
        Event.stub(:new).with({'these' => 'params'}) { mock_event(:save => false) }
        post :create, :event => {'these' => 'params'}
        assigns(:event).should be(mock_event)
      end

      it "re-renders the 'new' template" do
        Event.stub(:new) { mock_event(:save => false) }
        post :create, :event => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested event" do
        Event.stub(:find).with("37") { mock_event }
        mock_event.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :event => {'these' => 'params'}
      end

      it "assigns the requested event as @event" do
        Event.stub(:find) { mock_event(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:event).should be(mock_event)
      end

      it "redirects to the event" do
        Event.stub(:find) { mock_event(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(event_url(mock_event))
      end
    end

    describe "with invalid params" do
      it "assigns the event as @event" do
        Event.stub(:find) { mock_event(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:event).should be(mock_event)
      end

      it "re-renders the 'edit' template" do
        Event.stub(:find) { mock_event(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end


    it "主催者だけがイベントを削除できる"
    it "主催者だけがイベントを変更できる" do 
      org = Factory.create(:member, :name => 'org')
      my_event = Factory.create(:event, :organizer => org, :contents => 'my event')
      ApplicationController.stub(:current_member).and_return(kato)
      my_event.update_attributes(:contents => 'kato\'s event!').should be_false
    end
    it "メンバーは自分が参加しているイベントをキャンセルすることができる" do 
      pending "EventsController に cancel メソッドを追加するまでペンディング"
    end
    it "メンバーは他人の参加をキャンセルすることはできない"
    it "自分が参加していないイベントをキャンセルしても何も変わらない"

  end
  
  describe "DELETE destroy" do
    it "destroys the requested event" do
      Event.stub(:find).with("37") { mock_event }
      mock_event.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the events list" do
      Event.stub(:find) { mock_event }
      delete :destroy, :id => "1"
      response.should redirect_to(events_url)
    end
  end

  end
end
