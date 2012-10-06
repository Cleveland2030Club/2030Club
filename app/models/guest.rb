class Guest < ActiveRecord::Base

  attr_accessible :first_name, :last_name, :email
  
  validates_presence_of :first_name, :last_name, :email
    
end
