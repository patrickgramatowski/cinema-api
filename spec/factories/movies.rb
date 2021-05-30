FactoryBot.define do
  factory :movie do
    sequence(:title) { |n| "Title_#{n}" }
    genre { random_genre }
    length { rand(90..118) }
  end
end

private

def random_genre
  genre_list = ["Comedy", "Horror", "Thriller", "Romance"]
  genre_list[rand(genre_list.size)]
end
