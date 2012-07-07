require 'spec_helper'

describe CategoriesController do
  describe "GET #show" do
    it "recognizes and generates #show" do
      { :get => 'membership_rewards/categories/1' }.should route_to(:controller => 'categories', :action => 'show', :id => '1')
    end
  end
end