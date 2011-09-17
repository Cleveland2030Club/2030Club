require 'spec_helper'

module Admin

  describe DashboardController do

    describe "get #index" do
      it "recoginizes and routes /admin/dashboard to DashboardController#index" do
        { :get => "/admin/dashboard" }.should route_to(:controller => 'admin/dashboard', :action => 'index')
      end
    end

  end

end
