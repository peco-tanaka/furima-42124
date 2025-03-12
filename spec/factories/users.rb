FactoryBot.define do
  factory :user do
    last_name             { "山田" }
    first_name            { "太郎" }
    last_name_kana        { 'カタカナ' }
    first_name_kana       { 'カタカナ' }
    nickname              { Faker::Internet.username }
    email                 { Faker::Internet.unique.email }
    password = "a1" + Faker::Internet.password(min_length: 6)
    password              { password }
    password_confirmation { password }
    birth_date            { Faker::Date.birthday(min_age: 18, max_age: 65) }

    trait :invalid do
      last_name { nil }
    end
  end
end