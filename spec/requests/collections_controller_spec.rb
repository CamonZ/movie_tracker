require 'rails_helper'

RSpec.describe "CollectionsControllers", type: :request do
  include RequestHelpers::JSON

  describe "GET /api/v1/collections" do

    before { create_list(:collection, 3) }

    it "responds with a collection of movies" do
      get '/api/v1/collections'

      expect(response).to be_successful
      expect(response).to be_a_serialized_collection_of(:collections).
                            of_length(3)
    end
  end

  describe "GET /api/v1/collections/:id" do

    let(:collection) { create(:collection) }

    it "responds with the specified collection" do
      expected_attributes = collection.
                              attributes.
                              except("created_at", "updated_at").
                              symbolize_keys

      get "/api/v1/collections/#{collection.id}"

      expect(response).to be_successful
      expect(response).to be_a_serialized(:collection).
                            with_attributes(expected_attributes)
    end
  end

  describe "POST /api/v1/collections/:id" do

    let(:collection_attributes) { attributes_for(:collection) }

    it "creates a new collection when requesting with the correct params" do
      post "/api/v1/collections", params: { collection: collection_attributes }

      expect(response).to be_created
      expect(response.location).to_not be_blank

      get response.location

      expect(response).to be_successful
      expect(response).to be_a_serialized(:collection).
                            with_attributes(collection_attributes)
    end
  end


  describe "PUT /api/v1/collections/:id" do
    let(:collection) { create(:collection) }
    
    it "updates the collection when requesting with proper params" do
      updated_title = "Foobar 10000"
      updated_attributes = collection.attributes.
        except("created_at", "updated_at").
        merge(title: updated_title).
        symbolize_keys

      put "/api/v1/collections/#{collection.id}",
        params: { collection: { title: updated_title } }

      expect(response).to be_accepted
      expect(response).to be_a_serialized(:collection).
                            with_attributes(updated_attributes)
    end
  end

  describe "DELETE /api/v1/collections/:id" do
    let(:collection) { create(:collection) }

    it "destroys the movie" do
      delete "/api/v1/collections/#{collection.id}"

      expect(response).to be_accepted

      get "/api/v1/collections/#{collection.id}"

      expect(response).to be_not_found
    end
  end
end

