require 'spec_helper'

module Admin
  describe ParticipantsController do

    before do
      user = mock("User", :admin? => true)
      @controller.stub(:requires_admin) { true }
      @category = mock_model(Category)
      @controller.stub(:get_categories) { [@category] }
    end

    describe "get #index" do
      before do
        @participants = [mock_model(Participant)]
        @regions = [mock_model(Region)]
        Participant.should_receive(:find).with(:all).and_return(@participants)
        Region.should_receive(:find).and_return(@regions)
        get :index
      end

      it "assigns Participants to @participants" do
        assigns(:participants).should == @participants
      end

      it "assigns Regions to @regions" do
        assigns(:regions).should == @regions
      end

      it "renders the index view" do
        response.should render_template 'index'
      end
    end

    describe "get #new" do
      before do
        @participant = mock_model(Participant)
        Participant.should_receive(:new).and_return(@participant)
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

    describe "post #create" do
      before do
        @participant = mock_model(Participant, :id => 1)
        Participant.stub(:new).and_return(@participant)
      end

      it "builds a new Participant with post params" do
        participant = mock_model(Participant)
        Participant.should_receive(:new).and_return(participant)
        participant.stub(:save)
        post :create
        assigns(:participant).should == participant
      end

      context "when valid" do
        it "saves the new Participant" do
          @participant.should_receive(:save).and_return(true)
          post :create
        end

        it "sets a flash message" do
          @participant.stub(:save).and_return(true)
          post :create
          flash[:notice].should == "Participant has been registered."
        end

        it "redirects to participants show page" do
          @participant.stub(:save).and_return(true)
          post :create
          response.should redirect_to admin_participant_path(@participant)
        end
      end

      context "when invalid" do
        it "renders the new template" do
          @participant.stub(:save).and_return(false)
          post :create
          response.should render_template 'new'
        end
      end
    end

    describe "get #edit" do

      before do
        @participant = mock_model(Participant, :id => 1)
        Participant.should_receive(:find).with('1').and_return(@participant)
        get :edit, :id => 1
      end

      it "assigns a specific instance of Participant to participant" do
        assigns(:participant).should == @participant
      end

      it "renders the edit view" do
        response.should render_template 'edit'
      end
    end

    describe "put #update" do
      before do
        @participant = mock_model(Participant, :id => 1)
        Participant.should_receive(:find).with('1').and_return(@participant)
      end

      context "when record is valid" do
        it "finds a specific instance of Participant" do
          @participant.stub(:update_attributes)
          put :update, :id => 1
          assigns(:participant).should == @participant
        end

        it "update the attributes for the participant" do
          @participant.should_receive(:update_attributes).and_return(true)
          put :update, :id => 1
        end

        it "provides flash notice update has been received successfully" do
          @participant.stub(:update_attributes).and_return(true)
          put :update, :id => 1
          flash[:notice].should == "Participant updated successfully."
        end

        it "redirect to the particpant show page" do
          @participant.stub(:update_attributes).and_return(true)
          put :update, :id => 1
          response.should redirect_to admin_participant_path(@participant)
        end
      end

      context "when record is invalid" do
        it "renders edit template" do
          @participant.should_receive(:update_attributes).and_return(false)
          put :update, :id => 1
          response.should render_template 'admin/participants/edit'
        end
      end
    end

    describe "delete #destroy" do

      before do
        @participant = mock_model(Participant, :id => 1)
        Participant.should_receive(:find).with('1').and_return(@participant)
      end

      it "assigns a specific instance of participant" do
        @participant.stub(:destroy)
        delete :destroy, :id => 1
        assigns(:participant).should == @participant
      end

      it "destroys the record" do
        @participant.should_receive(:destroy)
        delete :destroy, :id => 1
      end

      it "redirects to index" do
        @participant.stub(:destroy)
        delete :destroy, :id => 1
        response.should redirect_to admin_participants_path
      end

    end
  end
end
