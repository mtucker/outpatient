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

  def new
    @calendar_event = CalendarEvent.new
  end

  def create
    @calendar_event = CalendarEvent.new(calendar_event_params)

    unless @calendar_event.user
      @calendar_event.user = current_user
    end

    respond_to do |format|
      if @calendar_event.save
        format.html { redirect_to @calendar_event, notice: 'Calendar event was successfully created.' }
        format.js { render json: @calendar_event, methods: :title, status: :created }
      else
        format.html { render :new }
        format.js { render json: @calendar_event.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit

    if @calendar_event.type = 'Appointment'
      redirect_to "/appointments/#{@calendar_event.id}/edit"
    elsif @calendar_event.type = 'Availability'
      redirect_to "/availabilties/#{@calendar_event.id}/edit"
    end
    
  end

  # PATCH/PUT /calendar_events/1
  # PATCH/PUT /calendar_events/1.json
  def update
    respond_to do |format|
      if @calendar_event.update(calendar_event_params)
        format.html { redirect_to @calendar_event, notice: 'CalendarEvent was successfully updated.' }
        format.json { render json: @calendar_event, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @calendar_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendar_events/1
  # DELETE /calendar_events/1.json
  def destroy
    @calendar_event.destroy
    respond_to do |format|
      format.html { redirect_to calendar_event_url, notice: 'CalendarEventsController was successfully destroyed.' }
      format.json { head :no_content }
    end
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
