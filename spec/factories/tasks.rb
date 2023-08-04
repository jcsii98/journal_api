require 'faker'

FactoryBot.define do
  factory :task do
    name { Faker::Lorem.word }
    body { Faker::Lorem.word }
    association :category, factory: :category
  end
end