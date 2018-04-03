FactoryBot.define do
  factory :contact_address do
    association :contact, factory: :contact
    phone_number { Faker::PhoneNumber.cell_phone }
    street { Faker::Address.street_address }
    email { Faker::Internet.free_email }
    postcode { Faker::Address.zip_code }
    city { Faker::Address.city }
  end
end
