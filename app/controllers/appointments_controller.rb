class AppointmentsController < ApplicationController

  before_filter :authenticate_user!
  before_action :set_appointment, only: [:edit, :update]

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

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to calendar_provider_path(@appointment.user), notice: 'Your appointment was successfully updated.' }
        format.json { render json: @appointment, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  def appointment_params
      params.require(:appointment).permit(:id, :starts_at, :ends_at, :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time)
  end
end
