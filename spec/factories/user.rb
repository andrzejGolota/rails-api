FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.free_email }
    login { Faker::Internet.user_name }
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
      association :role, factory: :user_role
      remember_digest
    end

    factory :basic_user do
      active_user
      association :role, factory: :user_role
    end

    factory :premium_user do
      active_user
      association :role, factory: :paid_user_role
    end

    factory :mod_user do
      active_user
      association :role, factory: :mod_role
    end

    factory :admin_user do
      active_user
      association :role, factory: :admin_role
    end

    factory :inactive_user do
      inactive_user
      association :role, factory: :user_role
    end

    factory :oauth_user do
      uid
      provider
      active_user
      association :role, factory: :user_role
    end

    factory :invisible_user do
      active_user
      contact_visibility false
      association :role, factory: :user_role
    end

    factory :password_reset_user do
      active_user
      reset_digest
      reset_sent_date
      association :role, factory: :user_role
    end

    factory :user_with_inactive_role do
      active_user
      association :role, factory: :inactive_user_role
    end

  end

end
