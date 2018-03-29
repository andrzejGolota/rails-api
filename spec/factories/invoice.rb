FactoryBot.define do
  factory :invoice do
    basic_user
    association :client, factory: :basic_user
    invoice_number { Faker::Number.number(10) }
    subject { Faker::Lorem.word }
    company
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

    trait :refused do

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

    end

    factory :accepted_invoice do

    end

    factory :settled_invoice do

    end
  end
end
