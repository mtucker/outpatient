require 'rails_helper'

RSpec.describe AvailabilitiesController, :type => :controller do

  login_user

  describe 'GET index' do

    it 'gets availabilties within a date range' do
      included_availability = create(:availability, user: subject.current_user, starts_at: '2014-01-01T08:00:00-0500', ends_at: '2014-01-01T09:00:00-0500')
      excluded_availability = create(:availability, user: subject.current_user, starts_at: '2014-01-05T08:00:00-0500', ends_at: '2014-01-05T09:00:00-0500')

      get :index, {start: '2014-01-01', end: '2014-01-02'}
      expect(assigns(:availabilities)).to eq([included_availability])
    end

    it 'gets availabilties for user' do
      included_availability = create(:availability, user: subject.current_user, starts_at: '2014-01-01T08:00:00-0500', ends_at: '2014-01-01T09:00:00-0500')
      excluded_availability = create(:availability, starts_at: '2014-01-05T08:00:00-0500', ends_at: '2014-01-05T09:00:00-0500')

      get :index
      expect(assigns(:availabilities)).to eq([included_availability])
    end

  end

end