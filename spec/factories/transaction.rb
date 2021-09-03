FactoryBot.define do
  factory :transaction do
    result { success }
    creddit_card_number { Faker::Business.credit_card_number.delete('-') }
    creddit_card_expiration_date { Faker::Business.credit_card_expry_date }
    invoice
  end
end
