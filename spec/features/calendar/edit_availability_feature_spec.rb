require 'rails_helper' 

feature 'provider editing an appointment' do

  scenario 'clicks an appointment on the calendar and is presented with an edit form' do

    provider = provider_signs_in
    appointment = create :appointment

    visit edit_appointment_path(appointment)

    expect(page).to have_text('Edit this appointment')

    expect(page.find('input#appointment_starts_at_date').value).to eq(appointment.starts_at_date.to_formatted_date)
    expect(page.find('input#appointment_starts_at_time').value).to eq(appointment.starts_at_time.to_formatted_time)
    expect(page.find('input#appointment_ends_at_date').value).to eq(appointment.ends_at_date.to_formatted_date)
    expect(page.find('input#appointment_ends_at_time').value).to eq(appointment.ends_at_time.to_formatted_time)
    
  end

  scenario 'edits an appointment and sees the calendar updated', js: true do

    provider = provider_signs_in 
    appointment = create :appointment, {user: provider}

    visit edit_appointment_path(appointment)

    appointment.starts_at += 2.days 
    appointment.ends_at += 2.days 

    fill_in_calendar_event_form(appointment)
    click_button 'Save'

    expect(page).to have_text('Your appointment was successfully updated.')

  end

  scenario 'deletes an appointment and sees the event removed from the calendar' do

    provider = provider_signs_in 
    appointment = create :appointment, {user: provider}

    visit edit_appointment_path(appointment)
    click_link 'Delete'

    expect(page).to have_text('The appointment was successfully deleted.')
    expect(page).not_to have_calendar_event(appointment.type, appointment.starts_at, appointment.ends_at)

  end
  
end

