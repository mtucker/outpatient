require 'rails_helper'

feature 'Login' do
  scenario 'Provider logs in' do

    provider = create(:provider)

    visit '/login'

    fill_in 'Your email address.', :with => provider.email
    fill_in 'Your password.', :with => provider.password

    click_button 'Sign in'

    expect(page).to have_content("Provider Profile")

  end

  scenario 'Admin logs in' do

    admin = create(:administrator)

    visit '/login'

    fill_in 'Your email address.', :with => admin.email
    fill_in 'Your password.', :with => admin.password

    click_button 'Sign in'

    expect(page).to have_content("Dashboard")

  end

end
