require 'rails_helper'

RSpec.describe CalendarEvent, type: :model do
  context 'being queried' do
    it 'finds only events that start after a given date' do
      create(:calendar_event, starts_at: Time.now, ends_at: 1.day.from_now)
      create(:calendar_event, starts_at: 1.day.ago, ends_at: Time.now)

      expect(CalendarEvent.starts_after(Time.now.beginning_of_day).count).to eq(1)
    end

    it 'finds only events that start before a given date' do
      create(:calendar_event, starts_at: Time.now, ends_at: 1.day.from_now)
      create(:calendar_event, starts_at: 5.days.from_now, ends_at: 6.days.from_now)

      expect(CalendarEvent.starts_before(2.days.from_now).count).to eq(1)
    end
  end
end
