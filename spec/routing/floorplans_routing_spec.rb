require "rails_helper"

RSpec.describe FloorplansController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/floorplans").to route_to("floorplans#index")
    end

    it "routes to #new" do
      expect(:get => "/floorplans/new").to route_to("floorplans#new")
    end

    it "routes to #show" do
      expect(:get => "/floorplans/1").to route_to("floorplans#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/floorplans/1/edit").to route_to("floorplans#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/floorplans").to route_to("floorplans#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/floorplans/1").to route_to("floorplans#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/floorplans/1").to route_to("floorplans#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/floorplans/1").to route_to("floorplans#destroy", :id => "1")
    end

  end
end
