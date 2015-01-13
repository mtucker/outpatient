# These are helpers to interact with the calendar
# we use to manage Providers' schedules.
module CalendarHelpers

  # Simulates clicking on a FullCalendar datetime
  def day_click(calendar_selector, dttm)

    # Convert the date to an ISO 8601 formatted string
    dttm_string = dttm.strftime('%Y-%m-%dT%H:%M:%S%z')

    # Trigger FullCalendars 'dayClock' callback to simulate
    # a click on the JS calendar
    page.execute_script(
      "
        date = moment('#{dttm_string}', moment.ISO_8601);
        $('#{calendar_selector}').fullCalendar('trigger', 'dayClick', null, date, null, null);
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

end