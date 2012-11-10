require 'spec_helper'

describe UserSessionsController do
  describe "GET #new" do
    it "recognizes and generates #new" do
      { :get => 'user_session/new' }.should route_to(:controller => 'user_sessions', :action => 'new')
    end
  end

  describe "POST #create" do
    it "recognizes and generates #create" do
      { :post => 'user_session' }.should route_to(:controller => 'user_sessions', :action => 'create')
    end
  end

  describe "DELETE #destroy" do
    it "recognizes and generates #destroy" do
      { :delete => 'user_session' }.should route_to(:controller => 'user_sessions', :action => 'destroy')
    end
  end
end