FactoryBot.define do
  factory :company do
    name { Faker::Company.name }
    company_number { Faker::Company.norwegian_organisation_number }
    vat_number { Faker::Company.ein }
    street { Faker::Address.street_address }
    postcode { Faker::Address.zip_code }
    city { Faker::Address.city }
    region { Faker::Address.state }
    association :user, factory: :basic_user
    association :country
  end
end
