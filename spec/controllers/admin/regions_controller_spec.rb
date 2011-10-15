require 'spec_helper'

module Admin
  describe RegionsController do

    before do
      @controller.stub(:requires_admin).and_return(true)
    end

    describe "GET #new" do
      it "assigns a new instance of region to categories" do
        region = mock_model(Region)
        Region.should_receive(:new).and_return(region)

        get :new
        assigns(:region).should == region
      end
    end

    describe "POST #create" do
      context "When valid" do

        before do
          @region = mock_model(Region, :name => "Conventry")
          Region.stub(:new) { @region }
          @region.stub(:save) { true }
        end

        it "creates a new instance of region with submitted attributes" do
          Region.should_receive(:new).with("name" => "Conventry").and_return(@region)

          post :create, :region => {:name => "Conventry"}
          assigns(:region).should == @region
        end

        it "saves the record" do
          @region.should_receive(:save)

          post :create, :region => {:name => "Conventry"}
        end

        it "sets flash thanking the admin" do
          post :create, :region => {:name => "Conventry"}
          flash[:notice].should == "Thank you for adding a new region!"
        end

        it "redirects to the particpants index page" do
          post :create, :region => {:name => "Conventry"}
          response.should redirect_to(admin_participants_path)
        end
      end

      context "Whan invalid" do

        it "renders the new page" do
          region = mock_model(Region, :save => false)
          Region.stub(:new).and_return(region)

          post :create
          response.should render_template(:new)
        end
      end
    end

    describe "GET #edit"  do

      let(:region) { mock_model(Region, :id => 1, :name => "Region Name") }

      it "finds the region" do
        Region.should_receive(:find).with('1').and_return(region)

        get :edit, :id => 1
        assigns(:region).should == region
      end

      it "renders the edit form" do
        Region.stub(:find).with('1') { region }

        get :edit, :id => 1
        response.should render_template(:edit)
      end
    end

    describe "PUT #update" do
      context "When valid" do

        before do
          @region = mock_model(Region, :id => 1, :name => "Conventry")
          Region.stub(:find) { @region }
          @region.stub(:update_attributes) { true }
        end

        it "creates a new instance of region with submitted attributes" do
          Region.should_receive(:find).with("1").and_return(@region)

          put :update, :id => 1, :region => {:name => "Conventry"}
          assigns(:region).should == @region
        end

        it "updates the record" do
          @region.should_receive(:update_attributes).with("name" => "Conventry").and_return(true)

          put :update, :id => 1, :region => {:name => "Conventry"}
        end

        it "sets flash thanking the admin" do
          put :update, :id => 1, :region => {:name => "Conventry"}
          flash[:notice].should == "Region has been updated!"
        end

        it "redirects to the particpants index page" do
          put :update, :id => 1, :region => {:name => "Conventry"}
          response.should redirect_to(admin_participants_path)
        end
      end

      context "Whan invalid" do

        it "renders the edit page" do
          region = mock_model(Region, :update_attributes => false)
          Region.stub(:find).and_return(region)

          put :update, :id => 1
          response.should render_template(:edit)
        end
      end
    end

    describe "DELETE #destroy" do
      before do
        @region = mock_model(Region, :id => 1, :name => "Conventry")
        Region.stub(:find) { @region }
        @region.stub(:destroy)
      end

      it "finds the region" do
        Region.should_receive(:find).with('1').and_return(@region)
        delete :destroy, :id => 1
        assigns(:region).should == @region
      end

      it "deletes the region" do
        @region.should_receive(:destroy)
        delete :destroy, :id => 1
      end

      it "redirects to the participants page" do
        delete :destroy, :id => 1
        response.should redirect_to admin_participants_path
      end
    end
  end
end
