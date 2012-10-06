class UserAddress < ActiveRecord::Base
  belongs_to :user

  attr_accessible :address, :address2, :city, :state_code, :zip
end

