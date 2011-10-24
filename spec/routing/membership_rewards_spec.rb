require 'spec_helper'

describe MembershipRewardsController do
  describe "Routing" do
    describe "GET: index" do
      it "Recognizes and generates #index" do
       { :get => "/member-rewards" }.should route_to(:controller => "membership_rewards", :action => "index")
      end
    end
  end
end