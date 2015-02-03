require 'rails_helper' 

feature 'provider that wants to create an appointment' do

  scenario 'clicks the "Create Appointment" button and is presented with the form', js: true do
    provider_signs_in
    click_link 'Calendar'
    click_link 'Create Appointment'
    expect(page).to have_text('Schedule a new appointment')
    expect(page.find('input#appointment_starts_at_date').value).to eq(Time.now.to_formatted_date)
    expect(page.find('input#appointment_starts_at_time').value).to eq(Time.now.round_up_to_nearest_half_hour.to_formatted_time)
    expect(page.find('input#appointment_ends_at_date').value).to eq(Time.now.to_formatted_date)
    expect(page.find('input#appointment_ends_at_time').value).to eq(1.hour.from_now.round_up_to_nearest_half_hour.to_formatted_time)    
    expect(page).to have_button('Save')
  end

  scenario 'fills out the form correctly, clicks save and sees the appointment on the calendar page', js: true do
    provider_signs_in
    click_link 'Calendar'
    click_link 'Create Appointment'
    click_button 'Save'
    expect(page).to have_text('The appointment was successfully saved.')
    expect(page).to have_calendar_event('Available', Time.now, 1.hour.from_now)
  end

end

