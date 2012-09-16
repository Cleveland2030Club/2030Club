require 'spec_helper'

describe "membership_rewards/show" do

  before(:each) do
    assign(:participant, FactoryGirl.create(:membership_reward))
  end

  context "When the user not logged in" do
    it "should say not a member" do
      view.stub(:current_user) { nil }
      render
      rendered.should contain('Not a Member?')
    end
  end

  context "when the user is logged in and expired" do
    it "should say not a member" do
      view.stub(:current_user) { FactoryGirl.build(:user, :expired_at => Time.now - 1.day) }
      render
      rendered.should contain('Not a Member?')
    end
  end

  context "when the user is logged in and is current" do
    it "should say not a member" do
      view.stub(:current_user) { FactoryGirl.build(:user, :expired_at => Time.now + 1.day) }
      render
      rendered.should_not contain('Not a Member?')
    end
  end

end