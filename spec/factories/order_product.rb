FactoryBot.define do
  factory :order_product do
    association :product, factory: :product
    association :order, factory: :order
  end
end
