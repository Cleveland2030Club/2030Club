require 'spec_helper'

describe "orders/new_order_event" do
  it "has all three fields needed for the TotalCalculator" do
    view.stub(:current_user) { FactoryGirl.create(:user) }
    event = FactoryGirl.build(:event)
    order = Order.new
    order.items << event.items[0]

    assign(:order, order)
    render

    rendered.should have_selector("span#event_price")
    rendered.should have_selector("input#quantity")
    rendered.should have_selector("span#total")
  end
end
