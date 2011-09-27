require 'spec_helper'

module Admin

  describe LocationsController do

    describe "GET #new" do
      it "assigns a specific participant to @participant" do
        participant = mock_model(Participant)
        Participant.should_receive(:find).and_return(participant)

        get :new, :participant_id => 1
        assigns(:participant).should == participant
      end

      it "assigns a new instance of Location to @location" do
        participant = mock_model(Participant)
        location = mock_model(Location)
        Participant.stub(:find) { participant }
        Location.should_receive(:new).and_return(location)

        get :new, :participant_id => 1
        assigns(:location).should == location
      end

      it "renders the new template" do
        participant = mock_model(Participant)
        location = mock_model(Location)
        Participant.stub(:find) { participant }
        Location.stub(:new).and_return(location)

        get :new, :participant_id => 1
        response.should render_template('/new')
      end

    end
  end

end
