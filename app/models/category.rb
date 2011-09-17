class Category < ActiveRecord::Base
  has_many :participants
end
