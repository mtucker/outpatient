require 'rails_helper'

RSpec.describe CalendarEventsController, :type => :controller do

  login_user

  describe 'GET new' do

    it 'assigns a new calendar_event as @calendar_event' do
      get :new
      expect(assigns(:calendar_event)).to be_a_new(CalendarEvent)
    end

  end

  describe 'POST create' do
    describe 'with valid params' do
      it 'creates a new CalendarEvent' do
        expect {
          post :create, calendar_event: FactoryGirl.attributes_for(:calendar_event);
        }.to change(CalendarEvent, :count).by(1)
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
  end

end
