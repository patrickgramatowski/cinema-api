FactoryBot.define do
  factory :ticket do
    price { 22 }
    seat { "A2" }
    ticket_type { "Normal" }
    reservation { create(:reservation) }
  end
end
