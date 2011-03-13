require File.dirname(__FILE__) + '/../spec_helper'

describe "orders new" do
  def setup
    :activate_authlogic
  end

  it "has all three fields needed for the TotalCalculator" do
    event = Factory.build(:event)
    order = Order.new
    order.items << event.items[0]

    assigns[:order] = order

    render '/orders/new_order_event.html.erb'
    
    response.should have_tag("span#event_price")
    response.should have_tag("input#quantity")
    response.should have_tag("span#total")
  end
end
