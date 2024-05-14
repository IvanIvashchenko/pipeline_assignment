# frozen_string_literal: true

FactoryBot.define do
  factory :deal do
    company
    name { Faker::Lorem.word }
    status { Deal::STATUSES.sample }
    amount { rand(1000) }
  end
end
