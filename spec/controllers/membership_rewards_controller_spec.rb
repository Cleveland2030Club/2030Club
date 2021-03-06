require 'spec_helper'

describe MembershipRewardsController do
  describe "GET #index" do
  
    it "sets @categories" do
      categories = [mock_model(Category)]
      Category.should_receive(:find).with(:all, :order => :name).and_return(categories)

      get :index
      assigns(:categories).should == categories
    end

    it "sets @participants" do
      participants = [mock_model(Participant)]
      Participant.should_receive(:find).with(:all, :order => :name).and_return(participants)

      get :index
      assigns(:participants).should == participants
    end
   
    it "sets @regions" do
      regions = [mock_model(Region)]
      Region.should_receive(:find).with(:all, :order => :name).and_return(regions)

      get :index
      assigns(:regions).should == regions
    end

  end
end