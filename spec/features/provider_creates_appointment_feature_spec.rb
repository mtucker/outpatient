require 'rails_helper'

feature 'Provider creates an Appointment' do

  scenario 'Provider clicks the Calendar and is presented with the option to create an Appointment', js: true do

    provider_signs_in

    click_link 'Calendar'

    click_day('#calendar', Time.now)

    expect(page).to have_select(
      'calendar_event_calendar_event_type_id', 
      with_options: [
        'Schedule availability for virtual appointments.', 
        'Schedule a virtual appointment.'
      ]
    )

  end

  scenario 'An Appointment and Calendar Event are created', js: true do

    provider_signs_in

    click_link 'Calendar'

    now = Time.now.round_down_to_nearest_half_hour

    click_day('#calendar', now)

    select('Schedule a virtual appointment.', from: 'calendar_event_calendar_event_type_id')

    click_button 'Save'

    within('.fc-event'){
      expect(page).to have_calendar_event('Available', now, now + 1.hour, 1)
    }

  end

end