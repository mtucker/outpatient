class AppointmentsController < ApplicationController

  before_filter :authenticate_user!

  def new
    @appointment = Appointment.new
  end

  def create
    @appointment = Appointment.new(appointment_params.merge(user_id: current_user.id))

    if @appointment.save
      redirect_to calendar_provider_path(@appointment.user), notice: 'The appointment was successfully saved.'
    else
      render :new, error: 'There was an error saving your appointment'
    end      
  end 

  def appointment_params
      params.require(:appointment).permit(:id, :calendar_event_type_id, :starts_at, :ends_at, :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time)
  end
end
