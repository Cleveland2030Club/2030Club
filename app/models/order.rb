class Order < ActiveRecord::Base
  belongs_to :customer, :polymorphic => true
  has_many :order_items
  has_many :items, :through => :order_items, :validate => true #, :join_table => 'order_items' 

  def paypal_amount
    amount * 100
  end

  def event_order?
    items[0].product.class == Event
  end
  
  def event
    items[0].product
  end
  
  def events
    event_items = order_items.select{|item| item.item_type == 'Event'}
    events = event_items.map do |item|
      event = Event.find(item.item_id)
    end
  end
  
end
