require 'rails_helper'

RSpec.describe ProvidersController, :type => :controller do

  describe 'GET #show' do

    it 'assigns a CalendarEvent of type ONLINE_APPOINTMENT_AVAILABLE to @calendar_event' do
      provider = create :provider
      get :show, {id: provider.id}
      expect(assigns(:calendar_event)).to be_a CalendarEvent
      expect(assigns(:calendar_event).calendar_event_type).to be_a CalendarEventType
    end

  end

end
