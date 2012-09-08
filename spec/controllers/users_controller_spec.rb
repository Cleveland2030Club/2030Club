require 'spec_helper'

describe UsersController do
  before(:each) do
    @controller.instance_eval{ flash.stub!(:sweep) }
  end

  context "password reminder" do

    it "validates email" do
      post 'send_password', { 'email' => 'someemail@'}
      response.should render_template 'forgotten'
      flash.now[:error].should eql 'The provided email is invalid'
    end

    it "errors out when the validated email is not in the DB" do
      User.stub!(:find_by_email).and_return(nil)

      post 'send_password', { 'email' => 'johndoe@gmail.com'}
      response.should render_template 'forgotten'
      flash.now[:error].should eql 'The provided email was not found'
    end

    it "sends an email with password reminder" do
      user = Factory.build(:user)
      User.stub!(:find_by_email).and_return(user)

      UserMailer.should_receive(:password_reminder_email).with(user)

      email = 'johndoe@gmail.com'

      post 'send_password', { 'email' => email}
      response.should render_template 'forgotten'
      flash.now[:notice].should eql 'An email has been sent with your password'
    end
  end
end

