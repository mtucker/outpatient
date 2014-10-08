require 'rails_helper'

RSpec.describe ProvidersRegistrationsController, :type => :controller do

  before do
    request.env["devise.mapping"] = Devise.mappings[:provider]
  end

  describe "GET #new" do

    it 'assigns a new Provider to @provider' do
      get :new
      expect(assigns(:provider)).to be_a Provider
    end

    it 'renders the :new template' do
      get :new
      expect(response).to render_template :new
    end

  end

  describe "POST #create" do

    # context 'with valid attributes' do
    #   it 'creates a new provider record in the database' do
    #     expect{post :create, provider: attributes_for(:provider)}.to change { User.count }.by(1)
    #   end
    #
    #   it 'redirects to the provider profile' do
    #     post :create, provider: attributes_for(:provider)
    #     expect(response).to redirect_to Provider.last
    #   end
    #
    # end

  end

end
