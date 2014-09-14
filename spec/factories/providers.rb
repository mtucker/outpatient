# Read about factories at https://github.com/thoughtbot/factory_girl
require 'faker'

FactoryGirl.define do
  factory :provider do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.zip_code { Faker::Address.zip }
    f.phone { Faker::PhoneNumber.phone_number }

    password = Faker::Internet.password
    f.password { password }
    f.password_confirmation { password }

  end
end
