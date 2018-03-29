FactoryBot.define do

  factory :role do
    name { Faker::Types.string }
    active true
  end

  factory :user_role, class: 'Role' do
    name "Invoice-App-FreeUser"
    active true
  end

  factory :paid_user_role, class: 'Role' do
    name "Invoice-App-PremiumUser"
    active true
  end

  factory :mod_role, class: 'Role' do
    name "Invoice-App-Mod"
    active true
  end

  factory :admin_role, class: 'Role' do
    name "Invoice-App-HeadAdmin"
    active true
  end

  factory :inactive_role, class: 'Role' do
    name { Faker::Types.string }
    active false
  end

end
