require 'rails_helper'

RSpec.describe 'Login' do

  describe 'Provider logs in' do

    it 'redirects to provider home' do

      provider = create(:provider)
      post '/login', :user => {:email => provider.email, :password => provider.password}

      expect(response).to redirect_to("/providers/#{assigns(:user).id}/home")

    end

  end

end