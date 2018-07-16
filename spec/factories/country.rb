FactoryBot.define do
  factory :country do
    country_name { "#{Faker::Address.country}#{Faker::Number.number(1)}" }
    country_code { "#{Faker::Address.country_code_long}#{Faker::Number.number(1)}" }
    active true
  end
end
