require 'rails_helper'

RSpec.describe Provider, :type => :model do

  context 'being validated' do

    let(:provider) { Provider.new }

    it 'requires a name' do
      expect(provider).to have_valid(:name).when(Faker::Name.name)
      expect(provider).not_to have_valid(:name).when(nil)
    end

    it 'requires a valid email' do
      expect(provider).to have_valid(:email).when(
        Faker::Internet.email
      )
      expect(provider).not_to have_valid(:email).when(
        nil,
        '',
        ' ',
        'invalid email',
        'invalid@email'
      )
    end

    it 'requires a strong password' do
      expect(provider).to have_valid(:password).when(Faker::Internet.password)
      expect(provider).not_to have_valid(:password).when(
        nil,
        '',
        ' ',
        'weak'
      )
    end

    it 'requires matching password and password confirmation' do
      provider.password = Faker::Internet.password
      expect(provider).to have_valid(:password_confirmation).when(provider.password)
      expect(provider).not_to have_valid(:password_confirmation).when(Faker::Internet.password)
    end

    it 'requires a phone number' do
      expect(provider).to have_valid(:phone).when(Faker::PhoneNumber.phone_number)
      expect(provider).not_to have_valid(:phone).when(
        nil,
        '',
        ' '
      )
    end

    it 'requires a zip code' do
      expect(provider).to have_valid(:zip_code).when(
          Faker::Address.zip_code,
          'hey this is valid too'
      )
      expect(provider).not_to have_valid(:zip_code).when(
          nil,
          '',
          ' '
      )
    end

  end

  context 'being created' do

    it 'is a User of type "Provider"' do

      user = create :provider
      expect(user.type).to eq 'Provider'

    end

    it 'is not active' do

      provider = create :provider
      expect(provider.is_active?).to eq false

    end

    it 'explicitly activated' do

      provider = create :active_provider
      expect(provider.is_active?).to eq true

    end

  end

  context 'being activated' do

    it 'updates activated_at' do

      provider = create :provider
      provider.is_active = true
      provider.save

      expect(provider.activated_at).not_to be_nil

    end

  end

  context 'being deactivated' do

    it 'updates deactivated_at' do

      provider = create :active_provider
      provider.is_active = false
      provider.save

      expect(provider.deactivated_at).not_to be_nil

    end

  end

end
