require 'rails_helper'

RSpec.describe Appointment, :type => :model do
    
  context 'being created' do
 
    it 'creates a CalendarEvent of type Appointment' do
  
      expect{ create :appointment }.to change{Appointment.count}.by(1)
      expect(CalendarEvent.last.type).to eq('Appointment')

    end

  end 

end
