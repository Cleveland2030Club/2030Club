require 'spec_helper'

describe MembershipRewardsController do
  describe "GET #index" do
  
    it "sets @categories" do
      categories = [mock_model(Category)]
      Category.should_receive(:all).and_return(categories)

      get :index
    end

    it "sets @participants" do
    end

  end
end