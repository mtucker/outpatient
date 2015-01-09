require 'rails_helper'

RSpec.describe CalendarEventsController, type: :controller do
  login_user

  describe 'GET index' do
    it 'gets calendar events within a date range' do
      included_event = create(:calendar_event, user: subject.current_user, starts_at: '2014-01-01T08:00:00-0500', ends_at: '2014-01-01T09:00:00-0500')
      excluded_event = create(:calendar_event, user: subject.current_user, starts_at: '2014-01-05T08:00:00-0500', ends_at: '2014-01-05T09:00:00-0500')

      get :index, start: '2014-01-01', end: '2014-01-02'
      expect(assigns(:calendar_events)).to eq([included_event])
    end

    it 'gets calendar events for user' do
      included_event = create(:calendar_event, user: subject.current_user, starts_at: '2014-01-01T08:00:00-0500', ends_at: '2014-01-01T09:00:00-0500')
      excluded_event = create(:calendar_event, starts_at: '2014-01-05T08:00:00-0500', ends_at: '2014-01-05T09:00:00-0500')

      get :index
      expect(assigns(:calendar_events)).to eq([included_event])
    end
  end

  describe 'GET new' do
    it 'assigns a new calendar_event as @calendar_event' do
      get :new
      expect(assigns(:calendar_event)).to be_a_new(CalendarEvent)
    end
  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new CalendarEvent' do
        expect do
          post :create, calendar_event: FactoryGirl.attributes_for(:calendar_event)
        end.to change(CalendarEvent, :count).by(1)
      end

      it 'assigns a newly created calendar_event as @calendar_event' do
        post :create, calendar_event: FactoryGirl.attributes_for(:calendar_event)
        expect(assigns(:calendar_event)).to be_a(CalendarEvent)
        expect(assigns(:calendar_event)).to be_persisted
      end

      it 'redirects to the created calendar_event' do
        post :create, calendar_event: FactoryGirl.attributes_for(:calendar_event)
        expect(response).to redirect_to(CalendarEvent.last)
      end

      it 'assigns the current logged in user to a new calendar_event when no user is specified' do
        post :create, calendar_event: FactoryGirl.attributes_for(:calendar_event)
        expect(CalendarEvent.last.user).to eql(controller.current_user)
      end

      it 'assigns the specified user to a new calendar_event' do
        user = FactoryGirl.create(:user)
        post :create, calendar_event: FactoryGirl.attributes_for(:calendar_event, user_id: user.id)
        expect(CalendarEvent.last.user).to eql(user)
      end
    end

    describe 'with invalid params' do
      it 'assigns a newly created but unsaved calendar_event as @calendar_event' do
        post :create, calendar_event: FactoryGirl.attributes_for(:invalid_calendar_event)
        expect(assigns(:calendar_event)).to be_a_new(CalendarEvent)
      end

      it 're-renders the "new" template' do
        post :create, calendar_event: FactoryGirl.attributes_for(:invalid_calendar_event)
        expect(response).to render_template('new')
      end
    end

    describe 'with separate start date and time' do
      it 'correctly saves the starts_at attribute' do
        calendar_event_attributes = FactoryGirl.attributes_for(:calendar_event_with_separate_date_and_times)
        puts calendar_event_attributes
        post :create, calendar_event: calendar_event_attributes
        expect(CalendarEvent.last.starts_at.strftime('%Y/%m/%d %I:%M %p')).to eq(calendar_event_attributes[:starts_at_date] + ' ' + calendar_event_attributes[:starts_at_time])
      end
    end
  end
end
