# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :calendar_event do |f|
    f.starts_at DateTime.now
    f.ends_at 1.hour.from_now 
    user
  end


  factory :invalid_calendar_event, parent: :calendar_event do |f|
    f.starts_at nil
  end
end
