module Admin
  class EventsController < Admin::BaseController

    def index
      @events = Event.where(start_at: (Time.now - 1.day)..(Time.now + 1.year)).order('start_at ASC')
      @title = 'Upcoming Events'
    end

    def past
      @events = Event.where(start_at: (Time.now - 3.months)..(Time.now)).order('start_at DESC')
      @title = 'Past Events'

      respond_to do |format|
        format.html { render template: 'admin/events/index.html.erb' }
      end
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
        redirect_to admin_events_path, notice: "Thank you for creating a new event"
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
