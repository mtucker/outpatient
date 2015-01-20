require 'rails_helper'

feature 'Provider deletes a Calendar Events' do

  scenario 'When an existing event is clicked, a delete option is presented', js: true do

    provider_signs_in

    click_link 'Calendar'

    now = Time.now.round_down_to_nearest_half_hour

    day_click('#calendar', now)

    click_button 'Save'

    within('.fc-event'){
      expect(page).to have_calendar_event(now, now + 1.hour)
    }

    event_click('#calendar',now, now + 1.hour)

    expect(page).to have_text('Delete')

  end

  scenario 'When an existing event is delete, the record disappears', js: true do

    provider_signs_in

    click_link 'Calendar'

    now = Time.now.round_down_to_nearest_half_hour

    day_click('#calendar', now)

    click_button 'Save'

    within('.fc-event'){
      expect(page).to have_calendar_event(now, now + 1.hour)
    }

    event_click('#calendar',now, now + 1.hour)

    expect(page).to have_text('Delete')

    click_link 'Delete'

    expect(page).not_to have_calendar_event(now, now + 1.hour)

  end

end