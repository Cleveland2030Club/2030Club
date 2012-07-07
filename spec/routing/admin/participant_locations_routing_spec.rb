require 'spec_helper'

module Admin

  describe LocationsController do

    context "Routing" do

      describe "GET #new" do
        it "recognizes and generates the #new" do
          { :get => '/admin/participants/1/locations/new' }.should route_to(:controller => 'admin/locations', :action => 'new', 
                                                                            :participant_id => '1')
        end
      end

      describe "POST #create" do
        it "recognizes and generates the #create" do
          { :post => '/admin/participants/1/locations' }.should route_to(:controller => 'admin/locations', :action => 'create', 
                                                                            :participant_id => '1')
        end
      end

      describe "GET #edit" do
        it "recognizes and generates the #edit" do
          { :get => '/admin/participants/1/locations/1/edit' }.should route_to(:controller => 'admin/locations', :action => 'edit', 
                                                                            :participant_id => '1', :id => '1')
        end
      end

      describe "PUT #update" do
        it "recognizes and generates the #update" do
          { :put => '/admin/participants/1/locations/1' }.should route_to(:controller => 'admin/locations', :action => 'update', 
                                                                            :participant_id => '1', :id => '1')
        end
      end

      describe "DELETE #destroy" do
        it "recognizes and generates the #destroy" do
          { :delete => '/admin/participants/1/locations/1' }.should route_to(:controller => 'admin/locations', :action => 'destroy', 
                                                                            :participant_id => '1', :id => '1')
        end
      end

    end

  end

end
