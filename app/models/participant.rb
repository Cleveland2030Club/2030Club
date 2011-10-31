class Participant < ActiveRecord::Base
  
  belongs_to :category
  has_many :locations
  
  validates_presence_of :name, :bio, :benefit, :instructions
  
  has_attached_file :logo, :styles => { :medium => "140x140", :thumb => "70x70" }

  def regions
    regions = []
    self.locations.each do |location|
      regions << location.region
    end
    regions
  end

end
