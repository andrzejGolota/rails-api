FactoryBot.define do
  factory :message do
    association :user, factory: :basic_user
    association :recipent, factory: :basic_user
    content { Faker::Lorem.sentence }

    factory :sent_message do
      state 'sent'
    end

    factory :received_message do
      state 'received'
      created_at Time.now
      received_at Time.now      
    end

  end

end
