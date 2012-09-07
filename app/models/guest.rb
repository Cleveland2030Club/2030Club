class Guest < ActiveRecord::Base

  attr_accessible :first_name, :last_name, :email
  
  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email,
    :with => RegistrationsHelper::EMAIL_REGEX,
    :if => :email?
    
end
