module FeatureHelpers
  def admin_logs_in
    admin = create(:administrator)

    sign_in_user(admin)
  end

  def provider_logs_in
    provider = create(:provider)

    sign_in_user(provider)
  end

  def sign_in_user(user)

    visit '/login'

    fill_in 'Your email address.', with: user.email 
    fill_in 'Your password.', with: user.password 

    click_button 'Sign in'

  end
end
