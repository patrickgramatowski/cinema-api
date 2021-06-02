FactoryBot.define do
  factory :reservation do
    seance_id { create(:seance).id }
    ticket_desk_id { create(:ticket_desk).id }
    status { "Not paid" }
  end
end
