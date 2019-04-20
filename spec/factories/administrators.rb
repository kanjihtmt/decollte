FactoryBot.define do
  factory :administrator do
    username { Faker::Name.name }
    password { Faker::Internet.password(8) }
  end
end
