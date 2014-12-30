class CalendarEventsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @calendar_events = CalendarEvent.where(nil) # creates an anonymous scope
    @calendar_events = @calendar_events.user(current_user)
    @calendar_events = @calendar_events.starts_after(params[:start]) if params[:start].present? 
    @calendar_events = @calendar_events.starts_before(params[:end]) if params[:end].present?

    respond_to do |format|
      format.html
      format.json { render json: @calendar_events } 
    end
  end

  def new
    @calendar_event = CalendarEvent.new
  end

  def create
    @calendar_event = CalendarEvent.new(calendar_event_params)

    if !@calendar_event.user
      @calendar_event.user = current_user
    end

    respond_to do |format|
      if @calendar_event.save
        format.html { redirect_to @calendar_event, notice: 'Calendar event was successfully created.' }
        format.js { render json: @calendar_event, status: :created }
      else
        format.html { render :new }
        format.js { render json: @calendar_event.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def calendar_event_params
    params.require(:calendar_event).permit(:user_id, :calendar_event_type_id, :starts_at, :ends_at, :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time)
  end

end
