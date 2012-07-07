require 'spec_helper'

module Static
  describe LogosController do
    describe "GET #index" do
      it "recognizes and generates #index" do
        { :get => '/logos' }.should route_to(:controller => 'static/logos', :action => 'index')
      end
    end
  end
end