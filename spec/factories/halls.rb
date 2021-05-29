FactoryBot.define do
  factory :hall do
    sequence(:hall) { |n| "Hall_#{n}" }
    capacity { 100 }
  end
end