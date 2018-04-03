FactoryBot.define do
  factory :contact do
    association :user, factory: :premium_user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }

    factory :contact_to_user do
      association :contact_user, factory: :premium_user
      accepted true
    end

    factory :contact_with_company do
      association :company, factory: :company
    end
  end
end
