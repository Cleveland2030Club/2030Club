require 'spec_helper'

describe EventsController do

  it "raises an exception when current_user is null" do
    lambda{ post :register_member }.should raise_error(ArgumentError)
  end

  it "creates a new order when registering a member" do
    event_id = 5
    created_order_id = 26
    current_user = Factory.build(:user)
    controller.stub!(:current_user).and_return(current_user)

    event = Factory.build(:event)
    Event.stub!(:find).and_return(event)
    OrdersHelper.stub(:create_event_order).and_return(created_order_id)

    post :register_member, {'event_id' => event_id}

    response.should be_redirect
    session[:order_id].should == created_order_id
  end
end

