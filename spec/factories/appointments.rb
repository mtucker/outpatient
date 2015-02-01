FactoryGirl.define do
  factory :appointment do |f|
    f.starts_at DateTime.now
    f.ends_at 1.hour.from_now
    user  
  end
end
