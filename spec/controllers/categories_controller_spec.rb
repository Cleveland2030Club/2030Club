require 'spec_helper'

describe CategoriesController do
  describe "GET #show" do
    before do
      @category = FactoryGirl.create(:category_with_participant)
    end

    it "sets categories to @categories" do
      get :show, :id => @category
      assigns(:categories).should == [@category]
    end

    it "sets regions to @regions" do
      pending "need to create location and region factories and instantiate them"
      regions = [mock_model(Region)]
      Region.should_receive(:find).and_return(regions)

      get :show, :id => @category.id
      assigns(:regions).should == regions
    end

    it "sets category to @category" do
      get :show, :id => @category.id
      assigns(:category).should == @category
    end

    it "sets participants to @participants" do
      get :show, :id => @category.id
      assigns(:participants).should == @category.participants.all
    end

  end
end