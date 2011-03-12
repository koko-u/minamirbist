# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :member do 
    name "no name"
    address "osaka"
    email { "#{name}@gmail.com" }
    sequence(:twitter_id) { |n| "twit_#{n}" }
    blog_url { "http://www.#{name}.com/" }
    birthday { (rand(20) + 10).years.ago }
    profile { "#{name} profile" }
    sequence(:uid) { |n| "%09d" % n }
    provider "twitter"
  end

  factory :event do
    name "no name"
    date_on { (rand(10) + 1).weeks.from_now }
    place "somewhere"
    association :organizer, :factory => :member
    contents { "#{organizer.name}'s event" }
  end

  factory :entry do 
    member
    event
  end
end
