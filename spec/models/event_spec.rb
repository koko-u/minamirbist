# -*- coding: utf-8 -*-
require 'spec_helper'

describe Event do
  it "Event には主催者がいる"
  it "イベント名は必須"
  it "登録する時、イベントの開催日は未来日付である"
  it "開催場所は必須"
  it "イベントには参加人数に上限がある"
  it "主催者だけがイベントの変更、削除ができる"
  it "イベントにメンバーは一度だけ参加できる"
end
