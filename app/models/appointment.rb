class Appointment < CalendarEvent 
  
  def title
    I18n.t 'activerecord.appointment.title'
  end

end
