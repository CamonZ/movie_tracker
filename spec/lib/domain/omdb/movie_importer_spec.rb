require 'rails_helper'
require "#{Rails.root}/lib/domain/omdb/movie_importer.rb"
require "#{Rails.root}/lib/domain/omdb/movie_wrapper.rb"


RSpec.describe MovieImporter do
  let(:imdb_id) { 'tt0468569' }
  let(:movie_attributes) do
    {
      :title => "The Dark Knight",
      :year => "2008",
      :rated => "PG-13",
      :released => "18 Jul 2008",
      :runtime => "152 min",
      :genre => "Action, Crime, Drama",
      :director => "Christopher Nolan",
      :writer =>
        "Jonathan Nolan (screenplay), Christopher Nolan (screenplay), Christopher Nolan (story), David S. Goyer (story), Bob Kane (characters)",
      :actors =>
        "Christian Bale, Heath Ledger, Aaron Eckhart, Michael Caine",
      :plot =>
        "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, the caped crusader must come to terms with one of the greatest psychological tests of his ability to fight injustice.",
      :language => "English, Mandarin",
      :country => "USA, UK",
      :awards => "Won 2 Oscars. Another 142 wins & 126 nominations.",
      :poster => "http://ia.media-imdb.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg",
      :metascore => "82",
      :imdb_rating => "9.0",
      :imdb_votes => "1,601,928",
      :imdb_id => "tt0468569",
      :type => "movie",
      :response => "True"
    }
  end

  describe "#fetched_movie" do
    it "returns the movie when there are no network errors", vcr: { cassette_name: "omdb_movie_fetch" } do
      movie = subject.fetched_movie(imdb_id)
      expect(movie).to eql(movie_attributes)
    end
  end

  describe "#import" do
    it "creates a new movie on the database when it hasn't been imported yet", vcr: { cassette_name: "omdb_movie_fetch" } do
      expect { subject.import(imdb_id) }.to change { Movie.count }.by(1)
    end

    it "raises an error when the movie has already been created", vcr: { cassette_name: "omdb_movie_fetch" } do
      existing_movie = Movie.create(MovieWrapper.new(movie_attributes).attributes)
      expect { subject.import(imdb_id) }.to raise_error { ActiveRecord::RecordInvalid }
    end
  end
end
