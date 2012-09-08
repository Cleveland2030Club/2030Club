class Location < ActiveRecord::Base

  attr_accessible :region_id, :address, :address_cont, :city, :zip, :google_map_link, :phone

  belongs_to :participant
  belongs_to :region

end
