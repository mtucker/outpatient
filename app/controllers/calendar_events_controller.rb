class CalendarEventsController < ApplicationController

  before_filter :authenticate_user!

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
        format.json { render :show, status: :created, location: @calendar_event }
      else
        format.html { render :new }
        format.json { render json: @calendar_event.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def calendar_event_params
    params.require(:calendar_event).permit(:user_id, :type, :starts_at, :ends_at)
  end

end
