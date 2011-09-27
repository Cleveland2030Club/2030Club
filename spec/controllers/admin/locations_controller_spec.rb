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
        @location.stub(:save).and_return(true)
        @participant.stub_chain(:locations, :build).and_return(@location)
      end

      it "assigns a participant to @participant" do
        post :create, :participant_id => 1
        assigns(:participant).should == @participant
      end
      
      context "Valid location" do

        it "assigns a new location to @location" do
          post :create, :participant_id => 1
          assigns(:location).should == @location 
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

    end
  end

end
