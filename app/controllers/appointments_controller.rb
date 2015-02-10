class AppointmentsController < CalendarEventsController

  before_filter :authenticate_user!
  before_action :set_appointment, only: [:edit, :update, :destroy]

  def new
    @appointment = Appointment.new
    @appointment.starts_at = Time.zone.now.round_up_to_nearest_half_hour
    @appointment.ends_at = @appointment.starts_at + 1.hour
  end

  def create
    @appointment = Appointment.new(appointment_params.merge(user_id: current_user.id))

    if @appointment.save
      redirect_to calendar_provider_path(@appointment.user), notice: 'Your appointment was successfully saved.'
    else
      flash.alert = 'There was an error saving your appointment.'
      render :new 
    end      
  end 

  def edit
    
  end

  def update
    if @appointment.update(appointment_params)
      redirect_to calendar_provider_path(@appointment.user), notice: 'Your appointment was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @appointment.destroy
    redirect_to calendar_provider_path(@appointment.user), notice: 'The appointment was successfully deleted.'
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
      params.require(:appointment).permit(:id, :starts_at, :ends_at, :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time)
  end
  
end
