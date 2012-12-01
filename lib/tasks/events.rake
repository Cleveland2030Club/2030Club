namespace :events do

  desc "Update event attendee count"
  task update_attendee_count: :environment do
    events = Event.all
    events.each do |event|
      puts "Updating #{event.name}"
      event.attendee_count = event.attendees.length
      event.max_attendance = event.max_attendance ? event.max_attendance : 50
      event.save
    end
  end

end