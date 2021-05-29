FactoryBot.define do
  factory :hall do
    sequence(:hall) { |n| "Hall_#{n}" }
    seats { 100 }
  end
end