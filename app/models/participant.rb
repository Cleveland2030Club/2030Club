class Participant < ActiveRecord::Base
  
  has_attached_file :logo, :styles => { :medium => "350x250>", :thumb => "175x125>" }
  
  validates_presence_of :name, :bio, :benefit, :instructions
end