# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :calendar_event do
    user nil
    type ""
    starts_at "2014-12-12 14:03:41"
    ends_at "2014-12-12 14:03:41"
  end
end
