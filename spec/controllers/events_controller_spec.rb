# -*- coding: utf-8 -*-
require 'spec_helper'

describe EventsController do
  before do
    @kato = Factory.create(:member, :name => 'kato')
    @wada = Factory.create(:member, :name => 'wada')
    @kato_event = Factory.create(:event, :name => 'kato\'s event',
                                 :organizer => @kato)
    @wada_event = Factory.create(:event, :name => 'wada\'s event',
                                 :organizer => @wada)
    login_as(@kato)
  end

  describe "GET index" do
    it "@events からすべての event が得られる" do
      get :index
      assigns(:events).should =~ [@kato_event, @wada_event]
    end
  end

  describe "GET show" do
    it "@event に必要となる event 情報が含まれている" do
      Event.expects(:find).with("37").returns(@kato_event)
      get :show, :id => "37"
      assigns(:event).should == @kato_event
    end
  end

  describe "GET for_organizer" do 
    it "異なる view を呼びたいだけで動きは show と同じ" do 
      Event.expects(:find).with("37").returns(@kato_event)
      get :for_organizer, :id => "37"
      assigns(:event).should == @kato_event
    end

    it "自分が主催するイベントでなければイベント一覧にリダイレクトする" do 
      Event.expects(:find).with("42").returns(@wada_event)
      get :for_organizer, :id => "42"
      response.should redirect_to events_path
    end
  end

  describe "GET new" do
    it "新規に作成した event は ログインユーザがその主催者となる" do
      get :new
      assigns(:event).organizer.should == @kato
    end
  end

  describe "GET edit" do
    it "@event に期待したイベントが保持される" do
      Event.expects(:find).with("37").returns(@kato_event)
      get :edit, :id => "37"
      assigns(:event).should == @kato_event
    end
    it "自分が主催しているイベントしか編集できない" do 
      Event.stubs(:find).with("37").returns(@wada_event)
      (get :edit, :id => "37").should redirect_to events_path
    end
  end

  describe "PUT cancel_event" do 
    before do 
      Event.stubs(:find).with("10").returns(@kato_event)
      @kato_event.expects(:cancel).with(@kato)
    end
    it "キャンセルしたら、プロフィールページにリダイレクト"  do
      (put :cancel, :id => "10").should redirect_to(profile_path)
    end

  end

  describe "POST create" do
    describe "入力した内容に問題がなかった場合" do
      before do 
        @normal_event = Factory.build(:event, :name => 'normal')
        post :create, :event => @normal_event.attributes
      end
      it "自動的にログインユーザが主催者とされる" do 
        assigns(:event).organizer.should == @kato 
      end
      it "主催イベントの参照ページに遷移する" do 
        response.should redirect_to for_organizer_event_path(assigns(:event))
      end
    end

    describe "入力した内容に問題があった場合" do
      before do 
        Event.any_instance.expects(:save).returns(false)
      end
      subject { post :create, :event => { :name => 'invalid' } }
      it { should render_template("new") }
    end

    describe "自分が主催するイベントしか登録できない" do 
      it "プロフィールページにリダイレクトする" do 
        pending "自分が主催するイベント以外を POST するような状況がよくわからない"
        oda = Factory.create(:member, :name => 'oda')
        post :create, :event => Factory.attributes_for(:event, :organizer => oda)
        response.should redirect_to profile_path
      end
    end
  end

  describe "PUT update" do
    describe "入力した内容に問題がなかった場合" do
      before do 
        @normal_event = Factory.build(:event, :name => 'normal',
                                      :place => 'where')
        Event.stubs(:find).with("37").returns(@normal_event)
      end
      it "Event#update_attributes が呼び出される" do
        @normal_event.expects(:update_attributes).with({'place' => 'here'})
        put :update, :id => "37", :event => {'place' => 'here'}
      end

      it "@event の内容が更新される" do
        put :update, :id => "37", :event => { 'place' => 'here' }
        assigns(:event).place.should == 'here'
      end

      it "主催者用のイベント参照ページにリダイレクト" do
        put :update, :id => "37", :event => { 'place' => 'here' }
        response.should redirect_to for_organizer_event_path(assigns(:event))
      end
    end

    describe "入力した内容に問題がある場合" do
      before do 
        @invalid_event = Factory.build(:event, :name => 'invalid')
        Event.stubs(:find).with("42").returns(@invalid_event)
        @invalid_event.stubs(:update_attributes).returns(false)
      end

      it "edit テンプレートにより再レンダリング" do
        put :update, :id => "42", :event => { 'place' => 'here' }
        response.should render_template("edit")
      end
    end

    describe "他人のイベントは更新できない" do 
      it "プロフィールページにリダイレクトされる" do 
        pending "自分が主催するイベント以外を PUT するような状況がよくわからない"
        Event.stubs(:find).with("42").returns(@wada_event)
        put :update, :id => "42", :event => { 'place' => 'here' }
        response.should redirect_to profile_path
      end
    end

  end

  describe "DELETE destroy" do
    context "Event#destroy が呼び出される" do 
      before do 
        @wrong_event = Factory.build(:event, :name => 'wrong event', :organizer => @kato)
        Event.stubs(:find).with("70").returns(@wrong_event)
        @wrong_event.expects(:destroy)
      end
      subject { delete :destroy, :id => "70" }
      it { should redirect_to my_events_path }
    end

    context "参加者がいても主催しているイベントを削除できる。
参加者がいる場合はもう少し親切な設計にするべきだが、今は問答無用で消せる" do 
      before  do
        @event = Factory.create(:event, :name => 'event', :organizer => @kato)
        @entry = Factory.create(:entry, :event => @event, :member => @wada)
      end
      subject { delete :destroy, :id => @event.id }
      it { should redirect_to my_events_path }
    end
  end
end
