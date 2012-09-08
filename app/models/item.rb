class Item < ActiveRecord::Base
  belongs_to :product, :polymorphic => true
  has_many :order_items
  has_many :orders, :through => :order_items

  attr_accessible :name, :price, :product
end

