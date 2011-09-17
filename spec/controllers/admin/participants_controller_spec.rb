require 'spec_helper'

module Admin
  describe ParticipantsController do
    describe "get #index" do
      before do
        @participants = [mock_model(::Participant)]
        ::Participant.should_receive(:find).with(:all).and_return(@participants)
        get :index      
      end
      
      it "assigns Participants to @participants" do
        assigns(:participants).should == @participants
      end
      
      it "renders the index view" do
        response.should render_template 'index'
      end
    end
    
    describe "get #new" do
      before do
        @participant = mock_model(::Participant)
        ::Participant.should_receive(:new).and_return(@participant)
        get :new        
      end
      
      it "assigns a new Participant to @participant" do
        assigns(:participant).should == @participant
      end
      
      it "renders the new view" do
        response.should render_template 'new'
      end
    end
    
    describe "get #show" do
      before do
        @participant = mock_model(Participant)
        Participant.should_receive(:find).with('1').and_return(@participant)
        get :show, :id => 1
      end
      
      it "finds and assigns Participant with id param" do    
        assigns(:participant).should == @participant
      end
      
      it "renders the show view" do
        response.should render_template 'show'
      end
    end
  end
end