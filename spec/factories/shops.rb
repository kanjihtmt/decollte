FactoryBot.define do
  factory :shop do
    name { Faker::Name.name }
    brand { create(:brand) }
  end
end
