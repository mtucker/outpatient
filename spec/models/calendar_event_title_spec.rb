require 'rails_helper'

RSpec.describe CalendarEvent, type: :model do
  context 'being asked for its title' do
    it 'returns correct title for Online Availability' do
      event = create(:calendar_event, starts_at: Time.now, ends_at: 1.day.from_now)

      expect(event.title).to eq('Available')
    end
  end
end
