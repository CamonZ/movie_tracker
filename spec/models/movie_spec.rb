require 'rails_helper'

RSpec.describe Movie, type: :model do

  it "has a valid factory" do
    movie = build(:movie)
    expect(movie).to be_valid
  end

  it { is_expected.to validate_presence_of(:imdb_id) }
  it { is_expected.to validate_uniqueness_of(:imdb_id) }

  describe ".import" do
    before { ResqueSpec.reset! }

    it "enqueues the movie imdb_id to be imported" do
      Movie.import('tt0468569')

      expect(MoviesImporterJob).to have_queued('tt0468569')
    end
  end
end
