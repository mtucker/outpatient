require 'rails_helper' 

feature 'provider creating an availability' do

  scenario 'is presented with a prefilled form', js: true do

    provider_signs_in

    click_link 'Calendar'
    click_link 'Create Availability'

    expect(page).to have_text('Schedule availability')
    expect(page.find('input#availability_starts_at_date').value).to eq(Time.now.to_formatted_date)
    expect(page.find('input#availability_starts_at_time').value).to eq(Time.now.round_up_to_nearest_half_hour.to_formatted_time)
    expect(page.find('input#availability_ends_at_date').value).to eq(Time.now.to_formatted_date)
    expect(page.find('input#availability_ends_at_time').value).to eq(1.hour.from_now.round_up_to_nearest_half_hour.to_formatted_time)    

    expect(page).to have_button('Save')
  end

  scenario 'submits form with prefill values', js: true do

    provider_signs_in

    click_link 'Calendar'
    click_link 'Create Availability'

    starts_at_date = page.find('input#availability_starts_at_date').value
    starts_at_time = page.find('input#availability_starts_at_time').value
    ends_at_date = page.find('input#availability_ends_at_date').value
    ends_at_time = page.find('input#availability_ends_at_time').value    
    
    click_button 'Save'

    starts_at = Time.parse_date_and_time(starts_at_date, starts_at_time)
    ends_at = Time.parse_date_and_time(ends_at_date, ends_at_time)

    expect(page).to have_text('Your availability was successfully saved.')
    expect(page).to have_calendar_event('Availability', starts_at, ends_at, 1)

  end

  scenario 'selects date and time in the future and submits form', js: true do

    provider_signs_in

    click_link 'Calendar'
    click_link 'Create Availability'

    starts_at = 1.day.from_now.round_up_to_nearest_half_hour
    ends_at = starts_at + 2.hours
    
    select_date('#availability_starts_at_date', starts_at)
    select_time('#availability_starts_at_time', starts_at)
    select_date('#availability_ends_at_date', ends_at)
    select_time('#availability_ends_at_time', ends_at)

    click_button 'Save'

    expect(page).to have_text('Your availability was successfully saved.')
    expect(page).to have_calendar_event('Availability', starts_at, ends_at, 1)

  end

  scenario 'selects end date preceding start date and submits form', js: true do

    provider_signs_in

    click_link 'Calendar'
    click_link 'Create Availability'

    starts_at = 1.day.from_now.round_up_to_nearest_half_hour
    ends_at = starts_at - 2.hours
    
    select_date('#availability_starts_at_date', starts_at)
    select_time('#availability_starts_at_time', starts_at)
    select_date('#availability_ends_at_date', ends_at)
    select_time('#availability_ends_at_time', ends_at)

    click_button 'Save'

    expect(page).to have_text('There was an error saving your availability.')
    expect(page).to have_text('An event must end after it starts!')

  end
  
end

