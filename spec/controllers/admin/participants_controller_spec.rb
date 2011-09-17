require 'spec_helper'

module Admin
  describe ParticipantsController do
    describe "get #index" do
      it "assigns Participants to @participants" do
        participants = [mock_model(::Participant)]
        ::Participant.should_receive(:find).with(:all).and_return(participants)
        get :index
        assigns(:participants).should == participants
      end
    end
  end
end