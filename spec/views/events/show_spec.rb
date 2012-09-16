require 'spec_helper'

describe "events/show" do

  before(:each) do
    assign(:event, FactoryGirl.create(:paid_event))
    assign(:guest, Guest.new())
  end

  context "When the user not logged in" do
    it "should show 'you must login before you can register as a member'" do
      view.stub(:current_user) { nil }
      render
      rendered.should contain(' before you can register as a member!')
    end
  end

  context "when the user is logged in and expired" do
    it "should say 'to get the club price'" do
      view.stub(:current_user) { FactoryGirl.build(:user, :expired_at => Time.now - 1.day) }
      render
      rendered.should contain('to get the club price.')
    end
  end

  context "when the user is logged in and is current" do
    it "should say not a member" do
      view.stub(:current_user) { FactoryGirl.build(:user, :expired_at => Time.now + 1.day) }
      render
      rendered.should_not contain('Register as a Non-Member')
    end
  end

end