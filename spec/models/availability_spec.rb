require 'rails_helper'

RSpec.describe Availability, :type => :model do

  context 'being created' do
 
    it 'creates a CalendarEvent of type Availability' do
  
      expect{ create :availability }.to change{Availability.count}.by(1)
      expect(CalendarEvent.last.type).to eq('Availability')

    end

  end

end
