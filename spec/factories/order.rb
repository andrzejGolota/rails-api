FactoryBot.define do
  factory :order do
    association :user, factory: :basic_user
    state 'new'

    factory :order_with_payment do
      transient do
        payments_count 1
      end
      after(:create) do |order, ev|
        create_list(:payment, ev.payments_count, order: order)
      end
    end

    factory :order_with_completed_payment do
      transient do
        payments_count 1
      end
      after(:create) do |order, ev|
        create_list(:payment, ev.payments_count, order: order, state: 'completed', paypal_id: 1)
      end
    end

  end
end
