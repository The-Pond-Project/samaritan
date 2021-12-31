require "rails_helper"

RSpec.describe StoriesController, type: :routing do
  describe "routing" do
    it "routes to #new" do
      expect(get: "/stories/new").to route_to("stories#new")
    end

    it "routes to #create" do
      expect(post: "/stories").to route_to("stories#create")
    end
  end
end
