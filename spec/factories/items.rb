FactoryBot.define do
  factory :item do
    name                    { Faker::Commerce.product_name.truncate(40) }
    description             { Faker::Lorem.sentence.truncate(1_000) }
    condition_id            { Faker::Number.between(from: 2, to: 7) }
    price                   { Faker::Number.between(from: 300, to: 9_999_999) }
    shipping_fee_status_id  { Faker::Number.between(from: 2, to: 3) }
    shipping_day_id         { Faker::Number.between(from: 2, to: 4) }
    prefecture_id           { Faker::Number.between(from: 2, to: 48) }
    category_id             { Faker::Number.between(from: 2, to: 11) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('spec/fixtures/sample.jpg'), filename: 'sample.jpg', content_type: 'image/jpeg')
    end
  end
end