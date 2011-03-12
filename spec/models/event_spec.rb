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
end
