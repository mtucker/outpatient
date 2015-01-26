require 'rails_helper'

feature 'Provider edits a Calendar Events' do

  scenario 'When an existing event is clicked, the edit form is presented', js: true do

    provider_signs_in

    click_link 'Calendar'

    now = Time.now.round_down_to_nearest_half_hour

    click_day('#calendar', now)

    click_button 'Save'

    within('.fc-event'){
      expect(page).to have_calendar_event(now, now + 1.hour)
    }

    click_event('#calendar',now, now + 1.hour)

    expect(page).to have_text('Edit availability for virtual visits.')

  end

  scenario 'When an existing event is edited, the record is updated', js: true do

    provider_signs_in

    click_link 'Calendar'

    now = Time.now.round_down_to_nearest_half_hour

    click_day('#calendar', now)

    click_button 'Save'

    within('.fc-event'){
      expect(page).to have_calendar_event(now, now + 1.hour)
    }

    click_event('#calendar',now, now + 1.hour)

    select_time('#calendar_event_ends_at_time', now + 2.hour)

    click_button 'Save'

    within('.fc-event'){
      expect(page).not_to have_calendar_event(now, now + 1.hour)
      expect(page).to have_calendar_event(now, now + 2.hour)

    }

  end

end