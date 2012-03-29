module OrdersHelper

  def self.create_membership_order(user)
    membership_status = MembershipStatus.new(user)
    membership = Membership.standard.first
    membership_item = case membership_status.status
    when :current, :current_with_less_than_30_days
      membership.items.find_by_name("Early Renewal")
    when :expired_with_less_than_30_days
      membership.items.find_by_name("Grace Period Renewal")
    when :expired
      membership.items.find_by_name("Late Renewal")
    else
      membership.items.find_by_name("New Membership")
    end

    raise StandardError, "Membership Item missing for status #{membership_status.status}" unless membership_item

    order = Order.new(
                  :customer => user,
                  :amount => membership_item.price)
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
