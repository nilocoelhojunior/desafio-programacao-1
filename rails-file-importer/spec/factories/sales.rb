# frozen_string_literal: true

FactoryBot.define do
  factory :sale do
    purchaser_name { Faker::Name.name }
    item_description { Faker::Lorem.sentence }
    item_price { Faker::Number.decimal(2) }
    purchase_count { Faker::Number.digit }
    merchant_address { Faker::Address.street_address }
    merchant_name { Faker::Name.name }
    user
  end
end
