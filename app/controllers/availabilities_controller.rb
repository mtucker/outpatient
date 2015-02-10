class AvailabilitiesController < CalendarEventsController

  before_filter :authenticate_user!
  before_action :set_availability, only: [:edit, :update, :destroy]

  def new
    @availability = Availability.new
    @availability.starts_at = Time.zone.now.round_up_to_nearest_half_hour
    @availability.ends_at = @availability.starts_at + 1.hour
  end

  def create
    @availability = Availability.new(availability_params.merge(user_id: current_user.id))

    if @availability.save
      redirect_to calendar_provider_path(@availability.user), notice: 'Your availability was successfully saved.'
    else
      flash.alert = 'There was an error saving your availability.'
      render :new 
    end      
  end 

  def edit

  end

  def availability_params
      params.require(:availability).permit(:id, :starts_at, :ends_at, :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time)
  end
  
  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_availability
    @availability = Availability.find(params[:id])
  end

  def availability_params
      params.require(:availability).permit(:id, :starts_at, :ends_at, :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time)
  end
  
end
