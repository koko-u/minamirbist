# -*- coding: utf-8 -*-
require 'spec_helper'

describe Event do
  let (:kato) { Factory.create(:member, :name => 'kato') }
  it "主催者が必須" do
    event = Factory.build(:event, :organizer => nil, :contents => 'c')
    event.should be_invalid
    event.organizer = kato
    event.should be_valid
  end
  it "イベント名は必須" do
    no_name_event = Factory.build(:event, :name => nil, :organizer => kato)
    no_name_event.should be_invalid
    named_event = Factory.build(:event, :name => 'oh mine', :organizer => kato)
    named_event.should be_valid
  end
  it "イベントの内容にアクセス" do
    event = Factory.create(:event, :organizer => kato)
    event.contents.should == "#{kato.name}'s event"
  end
  context "イベント開催日" do
    before do
      Timecop.freeze(Date.today)
    end
    after do
      Timecop.return
    end
    it "登録する時、イベントの開催日は未来日付である" do
      Timecop.freeze(Date.parse('2011-03-10'))
      event = Factory.build(:event, :organizer => kato)
      event.date_on = Date.parse('2011-03-11')
      event.should be_valid
      event.date_on = Date.parse('2011-03-10')
      event.should be_invalid
      event.date_on = Date.parse('2011-03-09')
      event.should be_invalid
    end
    it "イベント開催日当日も変更はできる" do
      Timecop.freeze(Date.parse('2011-03-10'))
      event = Factory.create(:event, :date_on => Date.parse('2011-03-11'),
                             :organizer => kato, :contents => 'old contents')
      Timecop.freeze(Date.parse('2011-03-11'))
      event.update_attributes(:contents => 'new contents').should be_true
      event.should be_valid
    end
  end
  it "開催場所は必須" do
    Factory.build(:event, :place => nil).should be_invalid
  end
  it "イベントには参加人数に上限がある" do 
    pending "Event モデルに参加人数上限のカラムを追加するまでペンディング"
  end
  context "イベントに参加する" do
    let(:event) { Factory.create(:event, :organizer => kato) }
    let(:wada) { Factory.create(:member, :name => 'wada')}
    it "イベントを新規作成した時点では参加者は 0人" do 
      event.entries.should be_empty
    end
    it "イベントに参加できる" do 
      expect { event.join(wada) }.to change { Entry.count }.by(1)
    end
    it "イベントに参加できると戻り値は true" do 
      event.join(wada).should be_true
    end
    it "イベントにメンバーは一度だけ参加できる" do 
      event.join(wada)
      event.join(wada).should be_false
      expect { event.join(wada) }.not_to change { Event.count }
    end
  end

  context "イベントをキャンセルする" do 
    let(:wada) { Factory.create(:member, :name => 'wada') }
    let!(:event) { Factory.create(:event, :organizer => kato) }
    let!(:entry) { Factory.create(:entry, :member => kato, :event => event) }
    context "実際にイベントに参加している参加者" do
      it "entry 自体が削除される" do 
        event.cancel(kato)
        Entry.where(:event_id => event, :member_id => kato).should be_empty
      end
      it "event.entries から参加者は削除される" do 
        event.cancel(kato)
        event.entries.should_not include(kato)
      end
      it "戻り値は true" do 
        event.cancel(kato).should be_true
      end
    end
    context "イベントに参加していない参加者をキャンセル" do 
      it "戻り値は false" do 
        event.cancel(wada).should be_false
      end
      it "event.entries の数は変わらない" do 
        expect { event.cancel(wada) }.not_to change { event.entries.count }
      end
    end
  end
end
