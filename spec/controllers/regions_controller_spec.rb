require 'spec_helper'

describe RegionsController do
  describe "GET #show" do
    it "sets categories to @categories" do
      categories = [mock_model(Category)]
      Category.should_receive(:find).and_return(categories)

      get :show, :id => 1
      assigns(:categories).should == categories
    end

    it "sets regions to @regions" do
      regions = [mock_model(Region)]
      Region.should_receive(:find).and_return(regions)

      get :show, :id => 1
      assigns(:regions).should == regions
    end

    it "sets region to @region" do
      regions = [mock_model(Region)]
      Region.should_receive(:find).and_return(regions)
      regions.should_receive(:select).and_return(regions)
      regions.stub(:first).and_return(regions.first)

      get :show, :id => 1
      assigns(:region).should == regions.first
    end

    it "sets participants to @participants"

  end
end