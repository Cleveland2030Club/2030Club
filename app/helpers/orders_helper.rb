module OrdersHelper

  def self.create_membership_order(user)
    membership = Membership.standard.first
    membership_item = membership.items[0]

    order = Order.new(
                  :customer => user,
                  :amount => membership.items[0].price)
    order.order_items << OrderItem.new(:order => order, 
                                       :item => membership_item,
                                       :quantity => 1)
    order.save!
    order.id
  end
  
  def self.create_event_order(user, event, quantity = 1)
    if user.class == Guest
      item = event.standard_price_item
    else 
      item = event.club_price_item
    end
    
    order = Order.new(
                  :customer => user,
                  :amount => item.price * quantity)
    order.order_items << OrderItem.new(:order => order,
                                       :item => item,
                                       :quantity => quantity)
    order.save!
    order.id
  end

end
