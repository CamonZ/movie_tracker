FactoryGirl.define do
  factory :user do
    email do |i|
      "test_user_#{i}@test.com"
    end
    password '12345678'
  end
end
