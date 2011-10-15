class Location < ActiveRecord::Base

  belongs_to :participant
  belongs_to :region

end
