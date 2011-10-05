class HomeController < ApplicationController

  def index
    @events = Event.coming_soon
    @sponsored_events = @events.with_sponsor
    @unsponsored_events = @events - @sponsored_events
  end
  
end

  
