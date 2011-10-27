require 'spec_helper'

describe MembershipRewardsController do
  describe "Routing" do
    describe "GET: index" do
      it "Recognizes and generates #index" do
       { :get => "/membership_rewards" }.should route_to(:controller => "membership_rewards", :action => "index")
      end
    end
    describe "GET: show" do
      it "Recognizes and generates #show" do
       { :get => "/membership_rewards/1" }.should route_to(:controller => "membership_rewards", :action => "index", :id => "1")
      end
    end
  end
end