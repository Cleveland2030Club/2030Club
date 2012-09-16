require 'spec_helper'

describe "events/show" do

  before(:each) do
    assigns[:event] = FactoryGirl.create(:paid_event)
    assigns[:guest] = Guest.new()
  end

  context "When the user not logged in" do
    it "should show 'you must login before you can register as a member'" do
      @controller.stub(:current_user => nil)
      render "/events/show"
      response.should include_text(' before you can register as a member!')
    end
  end

  context "when the user is logged in and expired" do
    it "should say 'to get the club price'" do
      @controller.stub(:current_user => FactoryGirl.build(:user, :expired_at => Time.now - 1.day))
      render "/events/show"
      response.should include_text('to get the club price.')
    end
  end

  context "when the user is logged in and is current" do
    it "should say not a member" do
      @controller.stub(:current_user => FactoryGirl.build(:user, :expired_at => Time.now + 1.day))
      render '/events/show'
      response.should_not include_text('Register as a Non-Member')
    end
  end

end