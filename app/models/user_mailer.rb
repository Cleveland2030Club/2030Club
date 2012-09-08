class UserMailer < ActionMailer::Base
  default :from => "Cleveland2030 Club <do_not_reply@cleveland2030.org>"
  default_url_options[:host] = "www.cleveland2030.org"

  def welcome_email(user)
    @events = Event.all(:conditions => ["start_at > DATE(?)", Time.now], :order => "start_at ASC", :limit => 5)
    @user = user
    @url = "http://cleveland2030.org/login"

    mail(
      :to => user.email,
      :subject => "Welcome to The Cleveland 2030 Club!",
      :bcc => "board@cleveland2030.org"
    )
  end

  def event_registration_email(user, event)
    @event = event
    @user = user
    @url = "http://cleveland2030.org"

    mail(
      :to => user.email,
      :subject => "Event registration successful",
      :bcc => "board@cleveland2030.org"
    )
  end

  def password_reset_instructions(user)
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token)

    mail(
      :to => user.email,
      :subject => "Password Reset Instructions"
    )
  end

  def renewal_email(user)
    @events = Event.all(:conditions => ["start_at > DATE(?)", Time.now], :order => "start_at ASC", :limit => 5)
    @user = user
    @url = "http://cleveland2030.org/login"

    mail(
      :to => user.email,
      :subject => "Membership Renewal",
      :bcc => "board@cleveland2030.org"
    )
  end

end
