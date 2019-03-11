# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '123456' }

    factory :user_with_sales do
      transient do
        sale_count { 2 }
      end
      after(:create) do |user, evaluator|
        create_list(:sale, evaluator.sale_count, user: user)
      end
    end
  end
end
