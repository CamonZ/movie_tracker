FactoryGirl.define do
  factory :movie do
    sequence :imdb_id do |n|
      "tt0#{n}"
    end
    sequence :title do |n|
      "The Dark Knight #{n}"
    end
  end
end
