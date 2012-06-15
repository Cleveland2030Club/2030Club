require 'spec_helper'

module Admin
  describe DashboardController do

    before do
      user = mock("User", :admin? => true)
      @controller.stub(:requires_admin) { true }
    end

    describe "get #index" do

      it "renders the admin layout" do
        get :index
        response.layout.should == 'layouts/admin'
      end

      it "renders the index view" do
        get :index
        response.should render_template 'index'
      end

    end
  end
end