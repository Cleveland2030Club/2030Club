require 'spec_helper'

describe OrdersController do

  before(:each) do
    @membership_order = FactoryGirl.build(:order)
    membership = FactoryGirl.build(:membership)
    membership.items[0].price = 70
    @membership_order.items = [membership.items[0]]
    @membership_order.order_items =
      [OrderItem.new(:order => @order, :item => membership.items[0], :quantity => 1)]

    @event_order = FactoryGirl.build(:order)
    event = FactoryGirl.build(:event)
    event.id = 49
    @event_order.items = [event.items[0]]
    order_item = OrderItem.new(:order => @event_order, :item => event.items[0], :quantity => 1)
    @event_order.order_items = [order_item]
    @event_order.amount = order_item.quantity * order_item.item.price

    session[:order_id] = 243
    @express_token = 'POR456MKLF'

    @gateway = mock(ActiveMerchant::Billing::BogusGateway)
    # Yeah, I know - it's only a test
    silence_warnings { GATEWAY = @gateway }
  end

  context "- for new action -" do

    it "displays the membership template when Order is non-event order" do
      Order.stub!(:find_by_id).and_return(@membership_order)

      get :new
      response.should render_template 'new_order_membership'
    end

    it "displays the event template when order is event order and amount > zero" do
      Order.stub!(:find_by_id).and_return(@event_order)
      @event_order.amount = 45

      get :new
      response.should render_template 'new_order_event'
    end

    it "displays the rsvp template when order is event order and amount is zero" do
      @event_order.amount = 0
      Order.stub!(:find_by_id).and_return(@event_order)

      get :new
      response.should render_template "new_order_rsvp"
    end
  end

  context "- for checkout -" do
    it "errors out when quantity is invalid" do
      @event_order.amount = 50
      Order.stub!(:find_by_id).and_return(@event_order)

      post :checkout, {"quantity" => "0"}
      response.should be_success
      response.should render_template("new_order_event")
      @event_order.order_items[0].should_not be_valid
      @event_order.order_items[0].errors.size.should == 1
    end

    it "calls the gateway and redirects to it" do
      @event_order.order_items[0].item.price = 20
      Order.stub!(:find_by_id).and_return(@event_order)
      @event_order.order_items[0].stub!(:save)

      setup_response = stub(:token => @express_token)

      @gateway.should_receive(:setup_purchase).and_return(setup_response)
      @event_order.stub!(:save)
      @gateway.should_receive(:redirect_url_for).with(@express_token).and_return('some url')

      post :checkout, {"quantity" => "2"}

      response.should redirect_to 'some url'
      @event_order.amount.should == 40
    end

    it "only updates quantity for event Orders" do
      Order.stub!(:find_by_id).and_return(@membership_order)
      @membership_order.order_items[0].stub!(:save)
      setup_response = stub(:token => @express_token)

      @gateway.should_receive(:setup_purchase).and_return(setup_response)
      @membership_order.stub!(:save)
      @gateway.should_receive(:redirect_url_for).with(@express_token).and_return('some url')

      post :checkout, {"quantity" => "2"}

      response.should redirect_to 'some url'
      @membership_order.amount.should == 70
    end
  end

  context "- for confirm -" do
    it "redirects to index if token was not found" do
      get :confirm
      response.should redirect_to '/orders/new'
    end

    it "sets the address from the GATEWAY response" do
      details_response = stub(:success? => true, :address => 'Some address')

      @gateway.should_receive(:details_for).with(@express_token).and_return(details_response)

      get :confirm, { :token => @express_token }
      response.should be_success
      assigns[:address].should_not be_nil
    end

    it "handles the error received in the GATEWAY response" do
      error_message = 'Hey, error occurred'
      details_response = stub(:success? => false, :message => error_message)

      @gateway.should_receive(:details_for).with(@express_token).and_return(details_response)

      get :confirm, { :token => @express_token }
      response.should render_template 'error'
      assigns[:message].should == error_message
    end
  end

  context "- for complete -" do
    it "renders error when the purchase was not successfull" do
      error_message = 'Error occurred'
      Order.stub!(:find_by_id).and_return(@membership_order)

      purchase = stub(:success? => false, :message => error_message)
      @gateway.should_receive(:purchase).and_return(purchase)

      get :complete
      response.should  render_template 'error'
      assigns[:message].should == error_message
    end
  end

  it "saves the payer_id and activates the user" do
    Order.stub!(:find_by_id).and_return(@membership_order)
    @membership_order.stub!(:save)
    @membership_order.stub_chain(:order_items, :first, :item, :name => "New Membership")

    user = FactoryGirl.build(:user)
    user.stub!(:activate_account!)
    @membership_order.customer = user

    UserMailer.should_receive(:welcome_email).with(user).
      and_return(double("mailer", :deliver => true))

    purchase = stub(:success? => true)
    @gateway.should_receive(:purchase).and_return(purchase)

    get :complete, {:payer_id => 2536}
    session[:order_id].should be_nil
    @membership_order.complete.should be_true
  end

  it "completes an event order and sends an email to the customer" do
    payer_id = 2536
    Order.stub!(:find_by_id).and_return(@event_order)
    @event_order.stub!(:save)

    UserMailer.should_receive(:event_registration_email).
      and_return(double("mailer", :deliver => true))

    purchase = stub(:success? => true)
    @gateway.should_receive(:purchase).and_return(purchase)

    get :complete, {:payer_id => payer_id}

    @event_order.express_payer_id.should == payer_id.to_s
    @event_order.should be_complete
    session[:order_id].should be_nil
  end

  it "errors out when quantity is invalid for RSVP order" do
    Order.stub!(:find_by_id).and_return(@event_order)

    post :complete_rsvp, {:quantity => 0}
    response.should render_template 'new_order_rsvp'
  end

  it "updates the quantity and closes the RSVP order" do
    Order.stub!(:find_by_id).and_return(@event_order)
    @event_order.order_items[0].stub!(:save)
    @event_order.stub!(:save)

    event = @event_order.items[0].product

    UserMailer.should_receive(:event_registration_email).
      with(@event_order.customer, event).
      and_return(double("mailer", :deliver => true))

    get :complete_rsvp, {:quantity => 3}

    response.should be_redirect
    session[:order_id].should be_nil
    @event_order.complete.should be_true
    @event_order.order_items[0].quantity.should == 3
  end
end
