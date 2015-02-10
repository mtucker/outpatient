class Appointment < CalendarEvent 
  
  def title
    I18n.t 'appointments.title'
  end

end
