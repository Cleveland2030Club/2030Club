class Participant < ActiveRecord::Base
  
  belongs_to :category
  has_many :locations
  
  validates_presence_of :name, :bio, :benefit, :instructions
  
  has_attached_file :logo, :styles => { :medium => "350x250>", :thumb => "175x125>" }
end
