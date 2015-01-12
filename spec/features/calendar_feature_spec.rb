require 'rails_helper'

feature 'Calendar' do

  scenario 'Provider clicks the Calendar and is presented with a new Calendar Event form', js: true do

    provider_logs_in

    click_link 'Calendar'

    expect(page).not_to have_text('Add Availability')

    day_click('#calendar', Time.zone.now)

    expect(page).to have_text('Add Availability')

  end

end