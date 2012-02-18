require 'spec_helper'

describe "members/index" do

  context "When the user not logged in" do
    it "should say not a member" do
      @controller.stub(:current_user => nil)

      render '/members/index'
      response.should include_text('Not a Member?')

    end
  end

  context "when the user is logged in and expired" do
    it "should say not a member" do
      @controller.stub(:current_user => Factory.build(:user, :expired_at => Time.now - 1.day))

      render '/members/index'
      response.should include_text('Not a Member?')
    end
  end

  context "when the user is logged in and is current" do
    it "should say not a member" do
      @controller.stub(:current_user => Factory.build(:user, :expired_at => Time.now + 1.day))
      
      assigns[:members] = stub_model(User, :total_pages => 0, :size => 0, :map => [])

      render '/members/index'
      response.should_not include_text('Not a Member?')
    end
  end

end