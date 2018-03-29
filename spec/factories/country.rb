FactoryBot.define do
  factory :country do
    country_name { Faker::Address.country }
    iso_code { Faker::Address.country_code_long }
    active true
  end
end
