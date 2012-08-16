class Region < ActiveRecord::Base

  attr_accessible :name
  has_many :locations
  validates :name, :presence => true, :uniqueness => { :scope => :name }

end
