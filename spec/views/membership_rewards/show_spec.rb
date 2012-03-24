require 'spec_helper'

describe "membership_rewards/show" do

  before(:each) do
    assigns[:participant] = Factory.create(:membership_reward)
  end

  context "When the user not logged in" do
    it "should say not a member" do
      @controller.stub(:current_user => nil)
      render "/membership_rewards/show"
      response.should include_text('Not a Member?')
    end
  end

  context "when the user is logged in and expired" do
    it "should say not a member" do
      @controller.stub(:current_user => Factory.build(:user, :expired_at => Time.now - 1.day))
      render '/membership_rewards/show'
      response.should include_text('Not a Member?')
    end
  end

  context "when the user is logged in and is current" do
    it "should say not a member" do
      @controller.stub(:current_user => Factory.build(:user, :expired_at => Time.now + 1.day))
      render '/membership_rewards/show'
      response.should_not include_text('Not a Member?')
    end
  end

end