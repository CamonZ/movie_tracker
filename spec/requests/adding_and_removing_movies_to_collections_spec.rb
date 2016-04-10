require 'rails_helper'

describe "MoviesController", type: :request do

  let(:collection) { create(:collection) }
  let(:movie) { create(:movie) }

  describe "when requesting with a non-existant collection" do
    it "returns not_found" do
      add_movie_to_collection_request(collection.id + 1, movie.id)

      expect(response).to be_not_found

      remove_movie_from_collection_request(collection.id + 1, movie.id)

      expect(response).to be_not_found
    end
  end

  describe "when requesting with a non-existant movie" do
    it "returns not_found" do
      add_movie_to_collection_request(collection.id, movie.id + 1)

      expect(response).to be_not_found

      remove_movie_from_collection_request(collection.id, movie.id + 1)

      expect(response).to be_not_found
    end
  end

  describe "POST /api/v1/collections/:collection_id/movies/add" do

    let(:serialized_movie) { movie.attributes.slice("id", "title", "imdb_id").symbolize_keys }

    context "when the movie is not part of the collection" do
      it "adds the movie to the collection" do
        add_movie_to_collection_request(collection.id, movie.id)

        expect(response).to be_accepted

        get "/api/v1/collections/#{collection.id}"

        expect(response).to be_successful
        expect(response).to be_a_serialized(:collection).
                              with_a_collection_of(:movies).
                              that_includes(serialized_movie)
      end
    end

    context "when the movie is already in the collection" do

      before { Movie.add_to_collection(collection.id, movie.id) }

      it "returns unprocessable entity" do
        add_movie_to_collection_request(collection.id, movie.id)

        expect(response).to be_unprocessable_entity
      end
    end
  end

  describe "DELETE /api/v1/collections/:collection_id/movies/remove" do

    context "when the movie is not in the collection" do

      before { collection.movies.delete_all }

      it "returns not_found" do
        remove_movie_from_collection_request(collection.id, movie.id)

        expect(response).to be_not_found
      end
    end


    context "when the movie is in the collection" do
      before { Movie.add_to_collection(collection.id, movie.id) }

      it "removes the movie from the collection" do
        remove_movie_from_collection_request(collection.id, movie.id)

        expect(response).to be_accepted

        get "/api/v1/collections/#{collection.id}"

        expect(response).to be_successful

        expect(response).to be_a_serialized(:collection).
                              with_a_collection_of(:movies).
                              that_is_empty
      end
    end
  end
end

def add_movie_to_collection_request(collection_id, movie_id)
  post "/api/v1/collections/#{collection_id}/movies/add", params: { movie_id: movie_id }
end

def remove_movie_from_collection_request(collection_id, movie_id)
  delete "/api/v1/collections/#{collection_id}/movies/remove", params: { movie_id: movie_id }
end
