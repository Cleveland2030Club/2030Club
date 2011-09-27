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

      it "assigns a participant to @participant" do
        post :create, :participant_id => 1, :location => {:address => '1 Main St' }
        assigns(:participant).should == @participant
      end
      
      context "Valid location" do

        it "assigns a new location to @location"

        it "saves the new location"

        it "sets the flash notice to 'Thank you for adding the location'"

        it "redirects to participant show page"
      end

    end
  end

end
