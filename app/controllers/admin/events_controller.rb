module Admin
  class EventsController < Admin::BaseController

    def index
      @events = Event.where(start_at: Time.now..(Time.now + 1.year)).order('start_at ASC')
    end

    def show
      @event = Event.find(params[:id])
      @attendees = @event.attendees
    end

    def new
      @event = Event.new(params[:event])
    end

    def create
      @event = Event.new(params[:event])
      if @event.save
        rediect_to admin_events_path, notice: "Thank you for creating a new event"
      else
        render :new
      end
    end

    def edit
      @event = Event.find(params[:id])
    end

    def update
      @event = Event.find(params[:id])
      if @event.update_attributes(params[:event])
        redirect_to admin_event_path(@event), notice: "Event updated"
      else
        render :edit
      end
    end

    def destroy
      @event = Event.find(params[:id])
      @event.destroy
      redirect_to admin_events_path
    end

  end
end