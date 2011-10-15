require 'spec_helper'

module Admin
  describe RegionsController do

    context "GET #new" do
      it "recognizes and generates #new" do
        { :get => '/admin/regions/new' }.should route_to(:controller => 'admin/regions', :action => 'new')
      end
    end

    context "GET #edit" do
      it "recognizes and generates #edit" do
        { :get => '/admin/regions/1/edit' }.should route_to(:controller => 'admin/regions', :action => 'edit', :id =>'1')
      end
    end

    context "POST #create" do
      it "recognizes and generates #create" do
        { :post => '/admin/regions' }.should route_to(:controller => 'admin/regions', :action => 'create')
      end
    end

    context "PUT #update" do
      it "recognizes and generates #update" do
        { :put => '/admin/regions/1' }.should route_to(:controller => 'admin/regions', :action => 'update', :id => '1')
      end
    end

    context "DELETE #destroy" do
      it "recognizes and generates #destroy" do
        { :delete => '/admin/regions/1' }.should route_to(:controller => 'admin/regions', :action => 'destroy', :id => '1')
      end
    end

  end
end
