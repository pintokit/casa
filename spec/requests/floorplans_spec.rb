require 'rails_helper'

RSpec.describe "Floorplans", type: :request do
  describe "GET /floorplans" do
    it "works! (now write some real specs)" do
      get floorplans_path
      expect(response).to have_http_status(200)
    end
  end
end
