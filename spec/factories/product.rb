FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    active true
    price { Faker::Commerce.price }
    duration { Faker::Number.between(1, 365)  }
  end
end
