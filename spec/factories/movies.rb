FactoryGirl.define do
  factory :movie_for_import, class: Movie do
    sequence :imdb_id do |n|
      "tt0#{n}"
    end

    factory :movie do
      sequence :title do |n|
        "The Dark Knight #{n}"
      end
    end
  end
end
