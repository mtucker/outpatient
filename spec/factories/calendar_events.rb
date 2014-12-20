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

  factory :calendar_event_with_separate_date_and_times, parent: :calendar_event do |f|
    f.starts_at nil
    f.ends_at nil
    f.starts_at_date Time.now.strftime('%Y/%m/%d')
    f.starts_at_time Time.now.strftime('%I:%M %p')
    f.ends_at_date 1.day.from_now.strftime('%Y/%m/%d')
    f.ends_at_time Time.now.strftime('%I:%M %p')
  end

end
