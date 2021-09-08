FactoryBot.define do
  factory :item do
    name { Faker::Appliance.equipment }
    sequence(:unit_price) { |n| n +150 }
    description { Faker::ChuckNorris.fact}
    merchant
  end
end
