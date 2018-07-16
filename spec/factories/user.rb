FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { "#{Faker::Lorem.characters(10)}#{Faker::Number.number(1)}@gmail.com" }
    login { "#{Faker::Lorem.word}#{Faker::Number.number(3)}" }
    password_digest { Faker::Internet.password(8, 30) }
    activation_sent_date DateTime.now
    avatar { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'support', 'avatar.png'), 'image/png') }

    trait :active_user do
      is_active true
      activated_at Faker::Time.between(DateTime.now - 365, DateTime.now)
    end

    trait :inactive_user do
      is_active false
      activated_at nil
    end

    factory :remembered_user do
      active_user
      role { Role.where(name: 'Invoice-App-FreeUser').first_or_create! }
      remember_digest
    end

    factory :basic_user do
      active_user
      role { Role.where(name: 'Invoice-App-FreeUser').first_or_create! }
    end

    factory :premium_user do
      active_user
      role { Role.where(name: 'Invoice-App-PremiumUser').first_or_create! }
      end

    factory :mod_user do
      active_user
      role { Role.where(name: 'Invoice-App-Mod').first_or_create! }
    end

    factory :admin_user do
      active_user
      role { Role.where(name: 'Invoice-App-HeadAdmin').first_or_create! }
    end

    factory :inactive_user do
      inactive_user
      role { Role.where(name: 'Invoice-App-FreeUser').first_or_create! }
    end

    factory :oauth_user do
      uid
      provider
      active_user
      role { Role.where(name: 'Invoice-App-FreeUser').first_or_create! }
    end

    factory :invisible_user do
      active_user
      contact_visibility false
      role { Role.where(name: 'Invoice-App-FreeUser').first_or_create! }
    end

    factory :password_reset_user do
      active_user
      reset_digest
      reset_sent_date
      role { Role.where(name: 'Invoice-App-FreeUser').first_or_create! }
    end

    factory :user_with_inactive_role do
      active_user
      association :role, factory: :inactive_user_role
    end

  end

end
