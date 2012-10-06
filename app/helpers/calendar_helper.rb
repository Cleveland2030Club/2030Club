module CalendarHelper
  def month_link(month_date)
    link_to(I18n.localize(month_date, :format => "%B"), {:month => month_date.month, :year => month_date.year})
  end
  
  # custom options for this calendar
  def event_calendar_opts
    { 
      :year => @year,
      :month => @month,
      :event_strips => @event_strips,
      :month_name_text => I18n.localize(@shown_month, :format => "%B %Y"),
      :previous_month_text => "<< " + month_link(@shown_month.prev_month),
      :next_month_text => month_link(@shown_month.next_month) + " >>"    }
  end

  def event_calendar
    # args is an argument hash containing :event, :day, and :options
    calendar event_calendar_opts do |args|
      event = Event.find(args[:event])
      if event.active?
        %(<a href="/events/#{event.id}" title="#{h(event.name)}">#{h(event.name)}</a>)
      elsif current_user
        if current_user.admin?
          %(<a class="not-active-event" href="/events/#{event.id}" title="#{h(event.name)}"><strong>NOT ACTIVE</strong> #{h(event.name)}</a>)
        else
          %(<style>div.ec-event-#{h(event.id)}{display:none;cursor:default;}</style> )
        end
      else
        %(<style>div.ec-event-#{h(event.id)}{display:none;cursor:default;}</style> )
      end
    end
  end
end