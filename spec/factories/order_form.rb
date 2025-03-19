FactoryBot.define do
  factory :order_form do
    postal_code   { Faker::Number.number(digits: 3).to_s + '-' + Faker::Number.number(digits: 4).to_s }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building_name { Faker::Address.secondary_address }
    phone_number  { '0' + Faker::Number.number(digits: 10).to_s }
    token         { SecureRandom.hex(16) }
  end
end