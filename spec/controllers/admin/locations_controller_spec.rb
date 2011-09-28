require 'spec_helper'

module Admin

  describe LocationsController do

    before do
      @participant = mock_model(Participant, :id => 1)
      Participant.stub(:find).and_return(@participant)
    end

    describe "GET #new" do
      it "assigns a specific participant to @participant" do
        Participant.should_receive(:find).and_return(@participant)

        get :new, :participant_id => 1
        assigns(:participant).should == @participant
      end

      it "assigns a new instance of Location to @location" do
        location = mock_model(Location)
        Location.should_receive(:new).and_return(location)

        get :new, :participant_id => 1
        assigns(:location).should == location
      end

      it "renders the new template" do
        location = mock_model(Location)
        Location.stub(:new).and_return(location)

        get :new, :participant_id => 1
        response.should render_template('/new')
      end
    end

    describe "POST #create" do

      before do
        @location = mock_model(Location)
        @participant.stub_chain(:locations, :build).and_return(@location)
        @location.stub(:save)
      end

      it "assigns a participant to @participant" do
        post :create, :participant_id => 1
        assigns(:participant).should == @participant
      end

      it "assigns a new location to @location" do
        post :create, :participant_id => 1
        assigns(:location).should == @location 
      end
      
      context "Valid location" do
        before do
          @location.stub(:save).and_return(true)
        end

        it "saves the new location" do
          @location.should_receive(:save).and_return(true)
          post :create, :participant_id => 1
        end

        it "sets the flash notice to 'Thank you for adding the location'" do
          post :create, :participant_id => 1
          flash[:notice].should == "Thank you for adding the location"
        end

        it "redirects to participant show page" do
          post :create, :participant_id => 1
          response.should redirect_to(admin_participant_path(@participant))
        end
      end

      context "Invalid location" do
        before do
          @location.stub(:save).and_return(false)
        end

        it "renders the new template" do
          post :create, :participant_id => 1
          response.should render_template('/new')
        end
      end
    end

    describe "GET #edit" do
      before do
        @participant.stub_chain(:locations, :find)
      end

      it "assigns a specific participant to @participant" do
        get :edit, :participant_id => 1, :id => 1
        assigns(:participant).should == @participant
      end

      it "renders the edit template" do
        get :edit, :participant_id => 1, :id => 1
        response.should render_template('/edit')
      end
    end

    describe "PUT #update" do
      
      it "finds the location" do
        location = mock_model(Location, :update_attributes => true)
        participant_locations = mock("Locations Collection")
        participant_locations.should_receive(:find).and_return(location)
        @participant.should_receive(:locations).and_return(participant_locations)

        put :update, :participant_id => 1, :id => 1
      end

      context "when updated attributes are valid" do
        before do
          @location = mock_model(Location)
          @participant.stub_chain(:locations, :find => @location)
        end

        it "updates attributes" do
          @location.should_receive(:update_attributes)
          put :update, :participant_id => 1, :id => 1
        end

        it "provides a notice the record was updates" do
          @location.stub(:update_attributes => true)
          put :update, :participant_id => 1, :id => 1
          flash[:notice].should == "Location has been updated"
        end

        it "redirects to participant show page" do
          @location.stub(:update_attributes => true)
          put :update, :participant_id => 1, :id => 1

          response.should redirect_to(admin_participant_path(@participant))
        end
      end
      context "when updated attributes are invalid" do
        it "renders the edit page" do
          @location = mock_model(Location)
          @location.stub(:update_attributes => false)
          @participant.stub_chain(:locations, :find => @location)

          put :update, :participant_id => 1, :id => 1
          response.should render_template('/edit')
        end
      end
    end

  end
end
