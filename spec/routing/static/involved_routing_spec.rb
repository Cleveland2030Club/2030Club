require 'spec_helper'

module Static
  describe AboutController do

    describe "GET /involved" do
      it "routes to static/involved#index" do
        get("/involved").should route_to(controller: "static/involved", action: "index")
      end
    end

    describe "GET /involved/educational" do
      it "routes to static/involved#educational" do
        get("/involved/educational").should route_to(controller: "static/involved", action: "educational")
      end
    end

    describe "GET /involved/philantrhipic" do
      it "routes to static/involved#philanthropic" do
        get("/involved/philanthropic").should route_to(controller: "static/involved", action: "philanthropic")
      end
    end

    describe "GET /involved/networking" do
      it "routes to static/involved#networking" do
        get("/involved/networking").should route_to(controller: "static/involved", action: "networking")
      end
    end

    describe "GET /involved/social" do
      it "routes to static/involved#networking" do
        get("/involved/social").should route_to(controller: "static/involved", action: "social")
      end
    end
  end
end