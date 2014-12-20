require 'rails_helper'

RSpec.describe Availability, :type => :model do

  context 'being created' do

    it 'is a CalendarEvent of type "Availability"' do

      event = create :availability
      expect(event.type).to eq 'Availability'

    end

  end

  context 'being queried' do

    it 'finds only availabilities that start after a given date' do

      create(:availability, starts_at: Time.now, ends_at: 1.day.from_now)
      create(:availability, starts_at: 1.day.ago, ends_at: Time.now)

      expect(Availability.starts_after(Time.now.beginning_of_day).count).to eq(1)

    end

    it 'finds only availabilities that start before a given date' do

      create(:availability, starts_at: Time.now, ends_at: 1.day.from_now)
      create(:availability, starts_at: 5.days.from_now, ends_at: 6.days.from_now)

      expect(Availability.starts_before(2.days.from_now).count).to eq(1)

    end

  end
  
end