class Membership < ActiveRecord::Base
  has_many :items,  :as => :product

  scope :standard, :conditions => {:name => 'Standard'}
end
