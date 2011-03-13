class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  validates_numericality_of :quantity
  validates_inclusion_of :quantity, :in => 1..100, :message => "can only be between 1 and 100"

  def item_type
    item.product_type
  end
  def item_id
    item.product_id
  end
end
