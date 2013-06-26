# -*- coding: utf-8 -*-
FactoryGirl.define do
  factory :section do 
    sequence(:name) { |n| "部署#{n}" }
  end

  factory :user do
    section
    sequence(:name) { |n| "name#{n}" }
    sequence(:nickname) { |n| "nickname#{n}" }
    sequence(:irc_name) { |n| "irc_name#{n}" }
    sequence(:github_uid) { |n| "00#{n}" } 
    job_type :engineer
  end 
end
