require 'spec_helper'

describe RegionsController do
  describe "GET #show" do
    it "recognizes and generates #show" do
      { :get => 'membership_rewards/regions/1' }.should route_to(:controller => 'regions', :action => 'show', :id => '1')
    end
  end
end