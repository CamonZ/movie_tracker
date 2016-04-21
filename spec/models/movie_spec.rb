require 'rails_helper'

RSpec.describe Movie, type: :model do
  let(:user) { create(:user) }

  it "has a valid factory" do
    movie = build(:movie)
    expect(movie).to be_valid
  end

  it { is_expected.to validate_presence_of(:imdb_id) }
  it { is_expected.to validate_uniqueness_of(:imdb_id) }
  it { is_expected.to validate_presence_of(:user) }

  describe ".import" do
    before { ResqueSpec.reset! }

    it "enqueues the movie imdb_id to be imported" do
      Movie.import('tt0468569', user.id)

      expect(MoviesImporterJob).to have_queued('tt0468569', user.id)
    end
  end

  describe ".add_to_collection" do
    let(:collection) { create(:collection) }
    let(:movie) { create(:movie) }

    it "adds the movie to the collection and increments the movies_counter on the collection" do
      Movie.add_to_collection(collection.id, movie.id)
      collection.reload

      expect(collection.movies).to include(movie)
      expect(collection.movies_count).to eql(1)
    end
  end

  describe ".remove_from_collection" do
    let(:collection) { create(:collection) }
    let(:movie) { create(:movie) }

    before { Movie.add_to_collection(collection.id, movie.id) }

    it "removes the movie to the collection and decrements the movies_counter on the collection" do
      Movie.remove_from_collection(collection.id, movie.id)
      collection.reload

      expect(collection.movies).to be_empty
      expect(collection.movies_count).to eql(0)
    end
  end
end
