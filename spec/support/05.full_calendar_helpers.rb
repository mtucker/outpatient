# These are helpers to interact with the FullCalendar
# JQuery plugin we use to manage Providers' schedules.
module FullCalendarHelpers

  # Simulates clicking on a FullCalendar datetime
  def day_click(calendar_selector, dttm)

    # Convert the date to an ISO 8601 formatted string
    dttm_string = dttm.strftime('%F')

    # Trigger FullCalendars 'dayClock' callback to simulate
    # a click on the JS calendar
    page.evaluate_script(
      "
        date = moment('#{dttm_string}', moment.ISO_8601);
        $('#{calendar_selector}').fullCalendar('trigger', 'dayClick', null, date, null, null);
      "
    )

  end

end