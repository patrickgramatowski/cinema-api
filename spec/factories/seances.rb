FactoryBot.define do
  factory :seance do
    date { "2021-05-31" }
    time { "16:30" }
    movie_id { create(:movie).id }
    hall_id { create(:hall).id }
  end
end
