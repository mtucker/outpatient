FactoryGirl.define do
  factory :availability do |f|
    f.starts_at DateTime.now
    f.ends_at 1.hour.from_now
    user
  end
end
