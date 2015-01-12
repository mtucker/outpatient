require 'rails_helper'

feature 'Login' do
  scenario 'Provider logs in' do
    provider = create(:provider)

    visit '/'

    expect(page).to have_text('Sign in')

    click_link('Sign in')

    fill_in 'Your email address.', with: provider.email
    fill_in 'Your password.', with: provider.password

    click_button 'Sign in'

    expect(page).to have_text('Sign out')
  end

  scenario 'Admin logs in' do
    admin_signs_in
  end
end
