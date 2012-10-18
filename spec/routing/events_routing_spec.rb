require 'spec_helper'

describe EventsController do

  describe "GET events/:id" do
    it "routes to events#show" do
      get("events/1").should route_to(controller: "events", action: "show", id: "1")
    end
  end

  describe "POST events/:id/register_member" do
    it "routes to events#show" do
      post("events/1/register_member").should route_to(controller: "events", action: "register_member", id: "1")
    end
  end

end