require 'rails_helper'

feature 'Provider Admin' do

  scenario 'Admin creates a Provider' do

    provider = build(:provider)

    admin_logs_in

    visit '/admin/providers/new'

    fill_in 'Name', :with => provider.name
    fill_in 'Email', :with => provider.email
    fill_in 'Password*', :with => provider.password
    fill_in 'Password confirmation', :with => provider.password
    page.select provider.specialty.name, :from => 'Specialty'
    fill_in 'Phone', :with => provider.password
    fill_in 'Zip code', :with => provider.zip_code

    click_button 'Create Provider'

    provider = Provider.find_by email: provider.email
    expect(provider.id).not_to be_nil
    expect(page).to have_content("Provider was successfully created.")

  end

  scenario 'Admin deletes a Provider' do

    provider = create(:provider)

    admin_logs_in

    visit "/admin/providers/#{provider.id}"

    click_link 'Delete Provider'

    expect{ Provider.find(provider.id) }.to raise_error(ActiveRecord::RecordNotFound)
    expect(Provider.with_deleted.find(provider.id)).not_to be_nil 

  end

end
