FactoryGirl.define do
  factory :collection do
    sequence :title do |n|
      "The Best Movies #{n}"
    end

    description "Lorem Ipsum Dolor Sit Amet"
  end
end
