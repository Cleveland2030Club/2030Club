require 'spec_helper'

module Admin
  describe CategoriesController do
    context "Routing" do

      describe "GET #new" do
        it "generates and responds to #new" do
          {:get => 'admin/categories/new'}.should route_to(:controller => 'admin/categories', :action => 'new')
        end
      end

      describe "POST #create" do
        it "generates and responds to #create" do
          {:post => 'admin/categories'}.should route_to(:controller => 'admin/categories', :action => 'create')
        end
      end

      describe "GET #edit" do
        it "generates and responds to #edit" do
          {:get => 'admin/categories/1/edit'}.should route_to(:controller => 'admin/categories', :action => 'edit', :id => '1')
        end
      end

      describe "PUT #update" do
        it "generates and responds to #update" do
          {:put => 'admin/categories/1'}.should route_to(:controller => 'admin/categories', :action => 'update', :id => '1')
        end
      end

      describe "DELETE #destroy" do
        it "generates and responds to #destroy" do
          {:delete => 'admin/categories/1'}.should route_to(:controller => 'admin/categories', :action => 'destroy', :id => '1')
        end
      end

    end
  end
end
