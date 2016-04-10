require 'rails_helper'

RSpec.describe "MoviesController", type: :request do
  include RequestHelpers::JSON

  describe "GET /api/v1/movies" do
    before do
      create_list(:movie, 3)
    end

    it "returns a collection of movies" do
      get '/api/v1/movies'

      expect(response).to be_successful
      expect(response).to be_a_serialized_collection_of(:movies).
                            of_length(3)
    end
  end

  describe "GET /api/v1/movies/:id" do
    let(:movie) { create(:movie) }
    it "returns the serialized movie" do
      get "/api/v1/movies/#{movie.id}"

      expect(response).to be_successful
      expect(response).to be_a_serialized(:movie)
    end
  end

  describe "POST /api/v1/movies/import" do
    let(:new_movie_attributes) { attributes_for(:movie_for_import) }

    it "creates a new movie when using correct params" do
      post "/api/v1/movies/import", params: { movie: new_movie_attributes }

      expect(response).to be_accepted
      expect(MoviesImporterJob).to have_queued(new_movie_attributes[:imdb_id])
    end
  end

  describe "PUT /api/v1/movies/:id" do
    let(:movie) { create(:movie) }
    let(:title) { { title: "Men in Black" } }
    let(:params) { { movie: title } }
    let(:updated_attributes) { { id: movie.id, imdb_id: movie.imdb_id }.merge(title) }

    it "updates the movie when requesting with proper params" do
      put "/api/v1/movies/#{movie.id}", params: params

      expect(response).to be_accepted
      expect(response).to be_a_serialized(:movie).with_attributes(updated_attributes)
    end
  end

  describe "DELETE /api/v1/movies/:id" do
    let(:movie) { create(:movie) }

    it "destroys the movie" do
      delete "/api/v1/movies/#{movie.id}"

      expect(response.body.strip).to be_empty
      expect(response).to be_accepted

      get "/api/v1/movies/#{movie.id}"

      expect(response).to be_not_found
    end
  end
end
