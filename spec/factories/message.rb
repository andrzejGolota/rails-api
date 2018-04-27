FactoryBot.define do
  factory :message do
    basic_user
    association :recipent, factory: :basic_user
    content { Faker::Lorem.sentence }

    factory :sent_message do
      state 'sent'
    end

    factory :received_message do
      state 'received'
      received_at DateTime.now
    end

  end

end
