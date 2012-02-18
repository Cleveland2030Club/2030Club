require 'spec_helper'

describe CategoriesController do
  describe "GET #show" do
    before do
      @category = mock_model(Category, :id => 1)
      Category.stub_chain(:find => [@category], :select => [@category], :first => @category)
    end

    it "sets categories to @categories" do
      Category.should_receive(:find).and_return([@category])

      get :show, :id => 1
      assigns(:categories).should == [@category]
    end

    it "sets regions to @regions" do
      regions = [mock_model(Region)]
      Region.should_receive(:find).and_return(regions)

      get :show, :id => 1
      assigns(:regions).should == regions
    end

    it "sets category to @category" do
      get :show, :id => 1
      assigns(:category).should == @category
    end

    it "sets participants to @participants" do
      participants = [mock_model(Participant)]
      Participant.should_receive(:find).and_return(participants)

      get :show, :id => 1
      assigns(:participants).should == participants
    end

  end
end