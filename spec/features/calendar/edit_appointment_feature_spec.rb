require 'rails_helper' 

feature 'provider editing an appointment' do

  scenario 'clicks an appointment on the calendar and is presented with an edit form', js: true do

    starts_at = 1.day.from_now.round_up_to_nearest_half_hour
    ends_at = starts_at + 1.hour
    
    provider_signs_in
    create_appointment(starts_at, ends_at)
    click_event('#calendar', starts_at, ends_at)

    expect(page).to have_text('Edit this appointment')

    expect(page.find('input#appointment_starts_at_date').value).to eq(starts_at.to_formatted_date)
    expect(page.find('input#appointment_starts_at_time').value).to eq(starts_at.to_formatted_time)
    expect(page.find('input#appointment_ends_at_date').value).to eq(ends_at.to_formatted_date)
    expect(page.find('input#appointment_ends_at_time').value).to eq(ends_at.to_formatted_time)
    
  end

  scenario 'edits an appointment and sees the calendar updated', js: true do

    starts_at = 1.day.from_now.round_up_to_nearest_half_hour
    ends_at = starts_at + 1.hour
    
    provider_signs_in
    create_appointment(starts_at, ends_at)
    click_event('#calendar', starts_at, ends_at)

    new_starts_at = starts_at + 2.days
    new_ends_at = new_starts_at + 1.hour

    select_date('#appointment_starts_at_date', new_starts_at)
    select_time('#appointment_starts_at_time', new_starts_at)
    select_date('#appointment_ends_at_date', new_ends_at)
    select_time('#appointment_ends_at_time', new_ends_at)

    click_button 'Save'

    expect(page).to have_text('Your appointment was successfully updated.')
    expect(page).to have_calendar_event('Appointment', new_starts_at, new_ends_at)
 
  end

  scenario 'deletes an appointment and sees the event removed from the calendar'
  
end

