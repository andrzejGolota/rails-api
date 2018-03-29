FactoryBot.define do
  factory :cost do
    name { Faker::Commerce.product_name }
    unit 'item'
    quantity { Faker::Number.between(1,10) }
    unit_price { Faker::Commerce.price }
    tax { Faker::Number.between(10, 30) }
    cost_type 'Product'
    basic_user
    created_invoice
  end
end
