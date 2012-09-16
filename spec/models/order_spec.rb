require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Order do
  before(:each) do
    @order = FactoryGirl.build(:order)
  end

  it { should belong_to :customer }
  it { should have_many :order_items }

  it "multiplies the amount by 100 for PayPal amount" do
    @order.amount = 50
    @order.paypal_amount.should == 5000
  end

  it "tells me if it's an event order" do
    event = FactoryGirl.build(:event)
    @order.items = [event.items[0]]
    @order.event_order?.should be_true
  end

  it "tells me it's not an event order when it's membership" do
    membership = FactoryGirl.build(:membership)
    @order.items = [membership.items[0]]
    @order.event_order?.should be_false
  end
end
