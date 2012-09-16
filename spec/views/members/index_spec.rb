require 'spec_helper'

describe "members/index" do

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
      assign(:members, stub_model(User, :total_pages => 0, :size => 0, :map => []))
      render
      rendered.should_not contain('Not a Member?')
    end
  end

end