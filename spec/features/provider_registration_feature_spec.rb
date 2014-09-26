require 'rails_helper'

feature 'Provider Registration' do
  scenario 'Guest registers as a provider' do

    provider = build(:provider)

    visit '/providers/register'

    fill_in 'Your full name.', :with => provider.name
    fill_in 'Your email address.', :with => provider.email
    fill_in 'Password.', :with => provider.password
    fill_in 'Password confirmation.', :with => provider.password
    fill_in 'Zip code of your practice.', :with => provider.zip_code
    fill_in 'Your phone number.', :with => provider.phone

    click_button 'Sign up'

    expect(page).to have_text('Welcome! You have signed up successfully.');
  end

  scenario 'Guest cannot register with invalid information' do

    provider = build(:provider)

    visit '/providers/register'

    click_button 'Sign up'

    expect(page).to have_text('Sign up');
  end
end
