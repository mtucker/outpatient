module FeatureHelpers

  def admin_logs_in

    admin = create(:administrator)

    visit "/login"

    fill_in 'Your email address.', :with => admin.email
    fill_in 'Your password.', :with => admin.password

    click_button 'Sign in'

    expect(page).to have_content("Dashboard")

  end

end
