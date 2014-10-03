require 'faker'

FactoryGirl.define do
  factory :administrator do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.email }

    password = Faker::Internet.password
    f.password { password }
    f.password_confirmation { password }
  end

end
