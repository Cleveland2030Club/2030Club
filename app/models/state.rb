class State < ActiveRecord::Base
  has_many :postal_codes, :dependent => :destroy
  
  attr_accessible :title, :code
  
  scope :by_name, lambda { |sname| { :conditions => ["LOWER(states.title) = ?", sname.downcase] }}
  scope :by_code, lambda { |code| { :conditions => ["LOWER(states.code) = ?", code.downcase] }}
  
  class << self
    def options
      self.all.map { |v| [v.title, v.id] }
    end
  end
  
  def postal_codes?
    self.postal_codes.any?
  end
end
