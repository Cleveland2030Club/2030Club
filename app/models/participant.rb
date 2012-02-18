class Participant < ActiveRecord::Base
  
  belongs_to :category
  has_many :locations
  
  validates_presence_of :name, :bio, :benefit, :instructions
  
  has_attached_file :logo, :styles => { :medium => "140x140", :thumb => "70x70" },
                           :storage => :s3,
                           :bucket => Cleveland2030Settings.config['S3_BUCKET'],
                           :s3_credentials => {
                             :access_key_id => Cleveland2030Settings.config['S3_KEY'],
                             :secret_access_key => Cleveland2030Settings.config['S3_SECRET']
                           },
                           :path => "logos/:id/:style/:filename"
  def regions
    regions = []
    self.locations.each do |location|
      regions << location.region
    end
    regions.compact
  end

end
