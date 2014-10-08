require 'faker'

FactoryGirl.define do
  factory :administrator do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }
    f.password { Faker::Internet.password }
    f.password_confirmation { "#{password}" }
  end
end
