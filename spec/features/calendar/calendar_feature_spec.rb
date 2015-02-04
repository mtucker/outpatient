require 'rails_helper'

feature 'user viewing their calendar' do

  scenario 'is presented with the option to create an Availability' do

    provider_signs_in

    click_link 'Calendar'

    expect(page).to have_link('Create Availability')

  end

  scenario 'is presented with the option to create an Appointment' do

    provider_signs_in

    click_link 'Calendar'

    expect(page).to have_link('Create Appointment')

  end 
  
end
