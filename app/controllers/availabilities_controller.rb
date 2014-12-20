class AvailabilitiesController < CalendarEventsController

  before_filter :authenticate_user!

  def index
    @availabilities = Availability.where(nil) # creates an anonymous scope
    @availabilities = @availabilities.user(current_user)
    @availabilities = @availabilities.starts_after(params[:start]) if params[:start].present? 
    @availabilities = @availabilities.starts_before(params[:end]) if params[:end].present?

    respond_to do |format|
      format.html
      format.json { render json: @availabilities } 
    end
  end

  def new
    @availability = Availability.new
  end

  def create
    @availability = Availability.new(availability_params)

    if !@availability.user
      @availability.user = current_user
    end

    respond_to do |format|
      if @availability.save
        format.html { redirect_to @availability, notice: 'Calendar event was successfully created.' }
        format.js { render json: @availability, status: :created }
      else
        format.html { render :new }
        format.js { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def availability_params
    params.require(:availability).permit(:user_id, :type, :starts_at, :ends_at, :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time)
  end

end
