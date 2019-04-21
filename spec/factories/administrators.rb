FactoryBot.define do
  factory :administrator do
    username { Faker::Lorem.characters(5) }
    password { Faker::Internet.password(8) }
    role { :admin }
  end
end
