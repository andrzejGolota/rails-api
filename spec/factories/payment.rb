FactoryBot.define do
  factory :payment do
    association :user, factory: :basic_user
    order
    state 'pending'
    amount { Faker::Commerce.price }
    paypal_id nil
  end
end
