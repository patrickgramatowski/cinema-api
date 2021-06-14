FactoryBot.define do
  factory :reservation do
    seance_id { create(:seance).id }
    ticket_desk_id { create(:ticket_desk).id }
    status { "pending" }
    seats { "A1" }
  end
end