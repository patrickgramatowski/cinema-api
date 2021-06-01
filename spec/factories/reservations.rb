FactoryBot.define do
  factory :reservation do
    seance_id { create(:seance).id }
  end
end
