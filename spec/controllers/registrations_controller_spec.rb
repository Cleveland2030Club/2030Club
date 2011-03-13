require 'spec_helper'

describe RegistrationsController do

  before(:each) do
    @create_post_values = {"first_name" => "John", "last_name" => "Doe",
      "email" => "jdoe@gmail.com", "password" => "password"}
  end

  it "returns a new Registration object when accessing GET /new" do
    get :new

    assigns[:registration].should_not be_nil
  end

  it "catches the model validation and stays on the create page" do
    @create_post_values["password"] = ""

    registration = Registration.new
    Registration.stub!(:new).with(@create_post_values).and_return(registration)

    # Call the action
    post 'create', {:registration => @create_post_values}

    registration.should_not be_valid

    assigns(:registration).should == registration
    response.should render_template 'new'
  end

  it "should register the user with valid input" do
    ORDER_ID = 2
    registration = stub(Registration)
    registration_converter = mock(ConvertsRegistrationToAccountInformation)
    user = User.new
    
    Registration.stub!(:new).with(@create_post_values).and_return(registration)
    ConvertsRegistrationToAccountInformation.stub!(:new).and_return(registration_converter)
    registration_converter.should_receive(:do_it).with(registration).and_return(user)
    OrdersHelper.stub!(:create_membership_order).and_return(ORDER_ID)

    registration.should_receive(:save).and_return(true)

    post 'create', {:registration => @create_post_values}

    response.should redirect_to(new_orders_path)
    session[:order_id].should == ORDER_ID
  end
end
