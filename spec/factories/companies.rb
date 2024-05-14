# frozen_string_literal: true

FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    industry { Faker::IndustrySegments.industry }
    employee_count { rand(1000) }
  end
end
