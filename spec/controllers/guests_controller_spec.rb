require 'spec_helper'

describe GuestsController do
  it "creates a Guest and Event Order" do
    event_id = 1
    guest = Factory(:guest)
    Guest.stub!(:new).and_return(guest)
    guest.stub!(:save).and_return(true)

    event = stub_model(Event)
    Event.stub!(:find).and_return(event)
    OrdersHelper.stub!(:create_event_order).with(guest, event).and_return(112)

    post 'create', {:guest => "some value", :event_id => event_id}
    response.should redirect_to(new_orders_path)
    session[:order_id].should == 112
  end

  it "sets flash message and renders events/show page when save fails" do
    guest = Factory(:guest)
    Guest.stub!(:new).and_return guest
    event = stub_model(Event)
    Event.stub!(:find).and_return(event)
    guest.stub!(:save).and_return false

    post 'create', {:guest => "some value", :event_id => 1}
    flash[:notice].should == "Please fix the errors and try again."
    response.should be_success 
  end
end
