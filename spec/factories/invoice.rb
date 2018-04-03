FactoryBot.define do
  factory :invoice do
    association :user, factory: :basic_user
    association :client, factory: :company
    invoice_number { Faker::Number.number(10) }
    subject { Faker::Lorem.word }
    association :company, factory: :company
    comment { Faker::Lorem.sentence }

    trait :draft do
      state 'draft'
    end

    trait :created do
      state 'created'
    end

    trait :pending do
      state 'pending'
    end

    trait :settled do
      state 'settled'
    end

    factory :invoice_draft do
      draft
    end

    factory :created_invoice do
      created
    end

    factory :invoice_with_costs do
      created
      transient do
        costs_count 5
      end
      after(:create) do |invoice, ev|
        create_list(:cost, ev.costs_count, invoice: invoice)
      end
    end

    factory :pending_invoice do
      pending
    end

    factory :settled_invoice do
      settled
    end
  end
end
