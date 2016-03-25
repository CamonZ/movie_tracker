require 'rails_helper'
require 'ostruct'
require "#{Rails.root}/lib/domain/omdb/movie_wrapper.rb"


RSpec.describe MovieWrapper do
  let(:movie_hash) do
    { :title=>"The Dark Knight",
      :year=>"2008",
      :rated=>"PG-13",
      :released=>"18 Jul 2008",
      :runtime=>"152 min",
      :genre=>"Action, Crime, Drama",
      :director=>"Christopher Nolan",
      :writer=>"Jonathan Nolan (screenplay), Christopher Nolan (screenplay), Christopher Nolan (story), David S. Goyer (story), Bob Kane (characters)",
      :actors=>"Christian Bale, Heath Ledger, Aaron Eckhart, Michael Caine",
      :plot=>"When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, the caped crusader must come to terms with one of the greatest psychological tests of his ability to fight injustice.",
      :language=>"English, Mandarin",
      :country=>"USA, UK",
      :awards=>"Won 2 Oscars. Another 142 wins & 126 nominations.",
      :poster=>"http://ia.media-imdb.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg",
      :metascore=>"82",
      :imdb_rating=>"9.0",
      :imdb_votes=>"1,601,928",
      :imdb_id=>"tt0468569",
      :type=>"movie",
      :response=>"True"
    }
  end

  it "returns the attributes necessary to build a Movie instance" do
    movie = MovieWrapper.new(OpenStruct.new(movie_hash))
    expect(movie.attributes).to eql({
      imdb_id: "tt0468569",
      title: "The Dark Knight",
      year: "2008",
      rating: "PG-13",
      release_date: Date.parse("2008/07/18"),
      runtime: 152,
      genre: "Action, Crime, Drama",
      director: "Christopher Nolan",
      writer: "Jonathan Nolan (screenplay), Christopher Nolan (screenplay), Christopher Nolan (story), David S. Goyer (story), Bob Kane (characters)",
      actors: "Christian Bale, Heath Ledger, Aaron Eckhart, Michael Caine",
      plot: "When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, the caped crusader must come to terms with one of the greatest psychological tests of his ability to fight injustice.",
      poster_location: "http://ia.media-imdb.com/images/M/MV5BMTMxNTMwODM0NF5BMl5BanBnXkFtZTcwODAyMTk2Mw@@._V1_SX300.jpg",
      imdb_rating: 90
    })
  end
end
