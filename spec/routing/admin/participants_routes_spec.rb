require 'spec_helper'

module Admin
  describe ParticipantsController do
    describe "get #index" do
      it "recognizes and routes /admin/participants to ParticipantsController#index" do
        { :get => '/admin/participants' }.should route_to(:controller => 'admin/participants', :action => 'index')
      end
    end
  end
end