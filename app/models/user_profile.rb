class UserProfile < ActiveRecord::Base
  belongs_to :user

  has_attached_file :avatar,
                    :styles => { :medium => "100x100>", :thumb => "50x50" },
                    :storage => :s3,
                    :bucket => Cleveland2030Settings.config['S3_BUCKET'],
                    :s3_credentials => {
                      :access_key_id => Cleveland2030Settings.config['S3_KEY'],
                      :secret_access_key => Cleveland2030Settings.config['S3_SECRET']
                    },
                    :path => "avatar/:id/:style/:filename",
                    :default_url => "/avatars/:style/missing.png"

  attr_accessible :phone_number, :profession, :employer, :education, :bio, :about2030

end