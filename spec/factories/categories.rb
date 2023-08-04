require 'faker'

FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word }
    association :user, factory: :user
  end
end