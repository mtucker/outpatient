require 'rails_helper'

RSpec.describe CalendarEvent, :type => :model do

  context 'being validated' do

    let(:calendar_event) { CalendarEvent.new }

    it 'requires a start time' do
      expect(calendar_event).to have_valid(:starts_at).when(Faker::Date.forward(1))
      expect(calendar_event).not_to have_valid(:starts_at).when(nil)
    end

    it 'requires an end time' do
      calendar_event.starts_at = DateTime.now
      expect(calendar_event).to have_valid(:ends_at).when(1.hour.from_now)
      expect(calendar_event).not_to have_valid(:ends_at).when(nil)
    end

    it 'requires a valid date for start time' do
      expect(calendar_event).not_to have_valid(:starts_at).when(123456)
      expect(calendar_event).not_to have_valid(:starts_at).when('Not a date')
    end

    it 'requires a valid date for end time' do
      expect(calendar_event).not_to have_valid(:ends_at).when(123456)
      expect(calendar_event).not_to have_valid(:ends_at).when('Not a date')
    end

    it 'requires an end time that is after the start time' do
      calendar_event.starts_at = DateTime.now
      expect(calendar_event).to have_valid(:ends_at).when(1.hour.from_now)
      expect(calendar_event).not_to have_valid(:ends_at).when(1.hour.ago)
    end


    it 'requires a valid type' do
      expect(calendar_event).to have_valid(:type).when('AVAILABLE')
      expect(calendar_event).not_to have_valid(:type).when(nil)
      expect(calendar_event).not_to have_valid(:type).when('INVALID_TYPE')
    end

  end

end
