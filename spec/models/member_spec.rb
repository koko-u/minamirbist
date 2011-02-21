# -*- coding: utf-8 -*-
require 'spec_helper'

describe Member do
  it "twitter id は必須" do
    member = Member.new
    member.should be_invalid
    member.errors[:twitter_id].should have(1).item
  end
end
