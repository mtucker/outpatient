# Manages requests for Calendar Events
#
# Calendar Events are also configured as a nested resource
# within Providers. So his controller can also be reached 
# via provider routes (e.g., '/providers/1/calendar_events')
class CalendarEventsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_calendar_event, only: [:show, :edit, :update, :destroy]

  def index
    @calendar_events = CalendarEvent.user(current_user)
      .starts_after(params[:start])
      .starts_before(params[:end])

    respond_to do |format|
      format.html
      format.json { render json: @calendar_events, methods: [:title, :type] }
    end
  end

  def edit
    redirect_to controller: @calendar_event.type.downcase.pluralize, action: :edit
  end

  def update
    if @calendar_event.update(calendar_event_params)
      redirect_to @calendar_event, notice: 'CalendarEvent was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @calendar_event.destroy
    redirect_to calendar_event_url, notice: 'CalendarEventsController was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_calendar_event
    @calendar_event = CalendarEvent.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def calendar_event_params
    params.require(:calendar_event).permit(:user_id, :id, :calendar_event_type_id, :starts_at, :ends_at, :starts_at_date, :starts_at_time, :ends_at_date, :ends_at_time)
  end
end
