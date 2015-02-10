require 'rails_helper'

feature 'user viewing their calendar' do

  scenario 'is presented with the option to create an Availability' do

    provider_signs_in

    click_link 'Calendar'

    expect(page).to have_link('Create Availability')

  end

  scenario 'is presented with the option to create an Appointment' do

    provider_signs_in

    click_link 'Calendar'

    expect(page).to have_link('Create Appointment')

  end 
  
  scenario 'sees an existing availability on the calendar', js: true do

    provider = provider_signs_in
    availability = create :availability, {user: provider}

    visit calendar_provider_path(provider)
    
    expect(page).to have_calendar_event(availability.type, availability.starts_at, availability.ends_at)

  end

  scenario 'sees an existing appointment on the calendar', js: true do

    provider = provider_signs_in
    appointment = create :appointment, {user: provider}

    visit calendar_provider_path(provider)
    
    expect(page).to have_calendar_event(appointment.type, appointment.starts_at, appointment.ends_at)

  end

  scenario 'is taken to the edit form when she clicks on an availability on the calendar', js: true do

    provider = provider_signs_in
    availability = create :availability, {user: provider}

    visit calendar_provider_path(provider)
    click_event('#calendar', availability.starts_at_time, availability.ends_at_time)

    expect(page).to have_text('Edit this availability')

  end
  
  scenario 'is taken to the edit form when she clicks on an appointment on the calendar', js: true do

    provider = provider_signs_in
    appointment = create :appointment, {user: provider}

    visit calendar_provider_path(provider)
    click_event('#calendar', appointment.starts_at_time, appointment.ends_at_time)

    expect(page).to have_text('Edit this appointment')

  end
  
end
