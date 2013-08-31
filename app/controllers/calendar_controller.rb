class CalendarController < ApplicationController

  def index
    @month = clean_month(params[:month].to_i)
    @year = clean_year(params[:year].to_i)

    @shown_month = Date.civil(@year, @month)

    @event_strips = Event.event_strips_for_month(@shown_month)

    @events = Event.coming_soon
    @sponsored_events = @events.with_sponsor
    @unsponsored_events = @events - @sponsored_events
  end

  private

  def clean_month(month)
    if month > 0 && month <= 12
      return month
    end
    return Time.zone.now.month
  end

  def clean_year(year)
    if year >= 1000 && year <= 9999
      return year
    end
    return Time.zone.now.year
  end
end
