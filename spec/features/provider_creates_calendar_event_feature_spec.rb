require 'rails_helper'

feature 'Provider creates a Calendar Events' do

  scenario 'Provider clicks the Calendar and is presented with a new Calendar Event form', js: true do

    provider_signs_in

    click_link 'Calendar'

    expect(page).not_to have_text('Schedule availability for virtual visits.')

    day_click('#calendar', Time.now)

    expect(page).to have_text('Schedule availability for virtual visits.')

  end

  scenario 'When the new Calendar Event form is submitted with valid information, a new event appears on the calendar', js: true do

    provider_signs_in

    click_link 'Calendar'

    now = Time.now.round_down_to_nearest_half_hour

    day_click('#calendar', now)

    click_button 'Save'

    within('.fc-event'){
      expect(page).to have_calendar_event(now, now + 1.hour)
    }

  end

  scenario 'When the new Calendar Event form is submitted with invalid information, errors are rendered on the page', js: true do

    provider_signs_in

    click_link 'Calendar'

    now = Time.now.round_down_to_nearest_half_hour

    day_click('#calendar', now)

    # Set starts at date after ends at date
    select_date('#calendar_event_starts_at_date', now + 4.days)

    click_button 'Save'

    expect(page).to have_text('An event must end after it starts!')

  end

  scenario 'After creating a new Calendar Event, the Provider reloads the page and the event is present on the calendar', js: true do

    provider_signs_in

    click_link 'Calendar'

    now = Time.now.round_down_to_nearest_half_hour

    day_click('#calendar', now)

    click_button 'Save'

    click_link 'Calendar'

    within('.fc-event'){
      expect(page).to have_calendar_event(now, now + 1.hour)
    }

  end

  @dttms = [
    Time.now,
    Time.now - 1.day,
    Time.now + 1.day,
    Time.now.beginning_of_day
  ]

  @dttms.each do |dttm|

    scenario 'New Calendar Event form is prepopulated with a date range based on where the user clicked', js: true do

      provider_signs_in

      click_link 'Calendar'

      now = dttm.round_down_to_nearest_half_hour

      day_click('#calendar', now)

      expect(page.find('input#calendar_event_starts_at_date').value).to eq(now.to_formatted_date)
      expect(page.find('input#calendar_event_starts_at_time').value).to eq(now.to_formatted_time)

      expect(page.find('input#calendar_event_ends_at_date').value).to eq(now.to_formatted_date)
      expect(page.find('input#calendar_event_ends_at_time').value).to eq((now + 1.hour).to_formatted_time)

    end

  end

end