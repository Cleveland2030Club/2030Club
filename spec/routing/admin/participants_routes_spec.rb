require 'spec_helper'

module Admin
  describe ParticipantsController do
    describe "get #index" do
      it "recognizes and routes /admin/participants to ParticipantsController#index" do
        { :get => '/admin/participants' }.should route_to(:controller => 'admin/participants', :action => 'index')
      end
    end
    
    describe "get #new" do
      it "recognizes and routes /admin/participants/new to ParticipantsController#new" do
        { :get => '/admin/participants/new' }.should route_to(:controller => 'admin/participants', :action => 'new')
      end
    end
    
    describe "get #show" do
      it "recognizes and routes /admin/participants/:id to ParticipantsController#show" do
        { :get => '/admin/participants/1' }.should route_to(:controller => 'admin/participants', :action => 'show', :id => '1')
      end
    end
  end
end