FactoryBot.define do
  factory :contact do
    basic_user
    contact_user_id nil #association :contact_user, factory: :basic_user
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    company nil
  end
end
