require 'spec_helper'

describe LogosController do
  describe "GET #index" do
    it "recognizes and generates #index" do
      { :get => '/logos' }.should route_to(:controller => 'logos', :action => 'index')
    end
  end
end