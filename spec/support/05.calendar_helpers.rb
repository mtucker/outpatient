# These are helpers to interact with the calendar
# we use to manage Providers' schedules.
module CalendarHelpers

  # Simulates clicking on a FullCalendar datetime
  def day_click(calendar_selector, dttm)

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
  def event_click(calendar_selector, start_dttm, end_dttm)

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

end