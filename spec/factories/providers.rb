require 'faker'

FactoryGirl.define do
  factory :provider do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.zip_code { Faker::Address.zip }
    f.phone { Faker::PhoneNumber.phone_number }
    f.password { Faker::Internet.password }
    f.password_confirmation { "#{password}" }
    specialty
  end

  factory :invalid_provider, parent: :provider do |f|
    f.name nil
  end

  factory :active_provider, parent: :provider do |f|
    f.is_active true
  end

end
