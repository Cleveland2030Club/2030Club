require 'spec_helper'

module Static
  describe AboutController do
    describe "GET /about" do
      it "routes to static/about#index" do
        get("/about").should route_to(controller: "static/about", action: "index")
      end
    end

    describe "GET /about/corporate" do
      it "routes to static/about#corporate" do
        get("/about/corporate").should route_to(controller: "static/about", action: "corporate")
      end
    end

    describe "GET /about/directors" do
      it "routes to static/about#directors" do
        get("/about/directors").should route_to(controller: "static/about", action: "directors")
      end
    end
  end
end