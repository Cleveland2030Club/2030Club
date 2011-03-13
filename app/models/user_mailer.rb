class UserMailer < ActionMailer::Base
  
  default_url_options[:host] = "www.cleveland2030.org"

  def welcome_email(user)
    recipients  user.email
    bcc         "technology@cleveland2030.org, info@cleveland2030.org"
    from        "Cleveland2030 Club <do_not_reply@cleveland2030.org>"
    subject     "Welcome to The Cleveland 2030 Club!"
    sent_on     Time.now
    body        :user => user, :url => "http://cleveland2030.org/login"
  end

  def event_registration_email(user, event)
    recipients  user.email
    bcc         "technology@cleveland2030.org, info@cleveland2030.org"
    from        "Cleveland2030 Club <do_not_reply@cleveland2030.org>"
    subject     "Event registration successful"
    sent_on     Time.now
    body        :user => user, :url => "http://cleveland2030.org", :event => event
  end

  def password_reset_instructions(user)
    subject     "Password Reset Instructions"
    from        "Cleveland2030 Club <do_not_reply@cleveland2030.org"
    recipients  user.email
    sent_on     Time.now
    body        :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
  end

end
