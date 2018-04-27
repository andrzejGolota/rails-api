FactoryBot.define do
  factory :payment do
    association :user, factory: :basic_user
    order
    state 'pending'
    amount { Faker::Commerce.price }

    factory :completed_payment do
      paypal_id { Faker::Number.between(1, 100) }
      state 'completed'
    end

  end
end
