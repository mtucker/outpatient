require 'rails_helper'

feature 'Provider creates a Appointment' do

  scenario 'Provider clicks the Calendar and is presented with the option to create an Appointment', js: true do

    provider_signs_in

    expect(page).not_to have_text('Schedule availability for virtual appointments.')

    click_link 'Calendar'

    click_day('#calendar', Time.now)

    expect(page).to have_text('Schedule availability for virtual appointments.')

  end

end