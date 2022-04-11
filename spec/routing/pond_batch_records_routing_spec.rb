require "rails_helper"

RSpec.describe PondBatchRecordsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/pond_batch_records").to route_to("pond_batch_records#index")
    end

    it "routes to #new" do
      expect(get: "/pond_batch_records/new").to route_to("pond_batch_records#new")
    end

    it "routes to #show" do
      expect(get: "/pond_batch_records/1").to route_to("pond_batch_records#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/pond_batch_records/1/edit").to route_to("pond_batch_records#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/pond_batch_records").to route_to("pond_batch_records#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/pond_batch_records/1").to route_to("pond_batch_records#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/pond_batch_records/1").to route_to("pond_batch_records#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/pond_batch_records/1").to route_to("pond_batch_records#destroy", id: "1")
    end
  end
end
