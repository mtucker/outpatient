# These are helpers to interact with the calendar
# we use to manage Providers' schedules.
module CalendarHelpers

  # Simulates clicking on a FullCalendar datetime
  def click_day(calendar_selector, dttm)

    # Convert the date to an ISO 8601 formatted string
    dttm_string = dttm.strftime('%Y-%m-%dT%H:%M:%S%z')

    # Trigger FullCalendars 'dayClick' callback to simulate
    # a click on the JS calendar
    page.execute_script(
      "
        date = moment('#{dttm_string}', moment.ISO_8601);
        $('#{calendar_selector}').fullCalendar('trigger', 'dayClick', null, date, null, null);
      "
    )

  end

  # Simultate clicking on a FullCalendar event
  def click_event(calendar_selector, start_dttm, end_dttm)

    event_dttm_range_string = "#{start_dttm.to_formatted_time} - #{end_dttm.to_formatted_time}"

    # Trigger FullCalendars 'eventClick' callback to simulate
    # a click on the JS calendar
    page.execute_script(
      "
        $(\"div[data-full='#{event_dttm_range_string}']\").click();
      "
    )

  end

  def select_date(date_picker_selector, date)

    date_string = date.strftime('%Y/%m/%d')

    page.execute_script(
      "
        $('#{date_picker_selector}').val('#{date_string}');
      "
    )

  end

  def select_time(time_picker_selector, dttm)

    time_string = dttm.to_formatted_time

    page.execute_script(
      "
        $('#{time_picker_selector}').val('#{time_string}');
      "
    )

  end

  def create_appointment(starts_at, ends_at)
  
    click_link 'Calendar'
    click_link 'Create Appointment'
  
    select_date('#appointment_starts_at_date', starts_at)
    select_time('#appointment_starts_at_time', starts_at)
    select_date('#appointment_ends_at_date', ends_at)
    select_time('#appointment_ends_at_time', ends_at)
    
    click_button 'Save'
    
  end

end
