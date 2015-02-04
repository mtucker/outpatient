require 'rails_helper'

RSpec.describe CalendarEventsController, type: :controller do
  login_user

  describe 'GET index' do
    it 'gets calendar events within a date range' do
      included_event = create(:calendar_event, user: subject.current_user, starts_at: '2014-01-01T08:00:00-0500', ends_at: '2014-01-01T09:00:00-0500')
      excluded_event = create(:calendar_event, user: subject.current_user, starts_at: '2014-01-05T08:00:00-0500', ends_at: '2014-01-05T09:00:00-0500')

      get :index, start: '2014-01-01', end: '2014-01-02', format: :json
      expect(assigns(:calendar_events)).to eq([included_event])
    end

    it 'gets calendar events for user' do
      included_event = create(:calendar_event, user: subject.current_user, starts_at: '2014-01-01T08:00:00-0500', ends_at: '2014-01-01T09:00:00-0500')
      excluded_event = create(:calendar_event, starts_at: '2014-01-05T08:00:00-0500', ends_at: '2014-01-05T09:00:00-0500')

      get :index, format: :json
      expect(assigns(:calendar_events)).to eq([included_event])
    end

    it 'includes title in event json' do
      create(:availability, user: subject.current_user, starts_at: '2014-01-01T08:00:00-0500', ends_at: '2014-01-01T09:00:00-0500')

      get :index, format: :json
      expect(assigns(:calendar_events).first.title).to eq('Available')
    end

    it 'includes type in event json' do
      create(:availability, user: subject.current_user, starts_at: '2014-01-01T08:00:00-0500', ends_at: '2014-01-01T09:00:00-0500')

      get :index, format: :json
      expect(assigns(:calendar_events).first.type).to eq('Availability')
    end

  end

end
