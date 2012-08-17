class Category < ActiveRecord::Base

  attr_accessible :name
  has_many :participants
  validates :name, :presence => true, :uniqueness => { :scope => :name }

end
