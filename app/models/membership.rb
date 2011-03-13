class Membership < ActiveRecord::Base
  has_many :items,  :as => :product

  named_scope :standard, :conditions => {:name => 'Standard'}
end
