module Admin
  class EventsController < Admin::BaseController

    def index
      @events = Event.where(start_at: Time.now..(Time.now + 1.year)).order('start_at ASC')
    end

    def show
      @event = Event.find(params[:id])
      @attendees = @event.attendees
    end

  end
end