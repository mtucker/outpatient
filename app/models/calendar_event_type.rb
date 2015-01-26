class CalendarEventType < ActiveRecord::Base

  def calendar_event_type_label

    I18n.t 'forms.calendar_events.calendar_event_types.online_appointment_availability.new'

  end

end
