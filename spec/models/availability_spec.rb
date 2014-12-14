require 'rails_helper'

RSpec.describe Availability, :type => :model do

  context 'being created' do

    it 'is a CalendarEvent of type "Availability"' do

      event = create :availability
      expect(event.type).to eq 'Availability'

    end

  end
  
end