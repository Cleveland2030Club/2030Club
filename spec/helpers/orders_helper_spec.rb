require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe OrdersHelper do

  it "creates new membership order" do
    user = FactoryGirl.build(:user)
    membership = FactoryGirl.build(:membership, :name => 'Standard')

    order = stub_model(Order, { :id => 112})

    Membership.stub!(:standard).and_return([membership])
    Membership.stub!(:first).and_return(membership)
    membership.stub_chain(:items,
      :find_by_name => FactoryGirl.create(
        :item, :name => "New Membership",
        :product_id => 1,
        :product_type => "Membership",
        :price => 50))
    Order.stub!(:new).and_return(order)
    order.stub!(:items).and_return([])
    order.stub!(:save!)

    order_id = OrdersHelper.create_membership_order(user)
    order_id.should == 112
  end

  it "creates new rsvp event order for members" do
    user = FactoryGirl.create(:user)
    event = FactoryGirl.build(:event)

    order_id = OrdersHelper.create_event_order(user, event)
    created_order = Order.find(order_id)

    created_order.customer.should == user
    created_order.items.length.should == 1
    created_order.items.first.should == event.club_price_item
    created_order.amount.should == BigDecimal('0.00')
  end

  it "creates new rsvp event order for 2 guests" do
    guest = FactoryGirl.build(:guest)
    event = FactoryGirl.build(:event)

    order_id = OrdersHelper.create_event_order(guest, event, 2)
    created_order = Order.find(order_id)

    created_order.customer.should == guest
    created_order.items.length.should == 1
    created_order.order_items.first.quantity.should == 2
    created_order.amount.should == BigDecimal('0.00')
  end

  it "creates new event order for 2 guests" do
    guest = FactoryGirl.build(:guest)
    event = FactoryGirl.build(:event)
    event.standard_price = 10.00

    order_id = OrdersHelper.create_event_order(guest, event, 2)
    created_order = Order.find(order_id)

    created_order.customer.should == guest
    created_order.items.length.should == 1
    created_order.order_items.first.quantity.should == 2
    created_order.amount.to_i.should == 20
  end

end
