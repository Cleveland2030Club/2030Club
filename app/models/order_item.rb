class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  validates_numericality_of :quantity
  validates_inclusion_of :quantity, :in => 1..100, :message => "can only be between 1 and 100"

  def item_type
    item.product_type if item
  end

  def item_id
    item.product_id if item
  end

end
