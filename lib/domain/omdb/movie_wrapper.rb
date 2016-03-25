class MovieWrapper

  def initialize(movie)
    @movie = movie
  end

  def attributes
    {
      imdb_id: imdb_id,
      title: title,
      year: year,
      rating: rating,
      release_date: release_date,
      runtime: runtime,
      genre: genre,
      director: director,
      writer: writer,
      actors: actors,
      plot: plot,
      poster_location: poster,
      imdb_rating: imdb_rating
    }
  end

  private

  delegate  :title, :year, :genre, :director,
            :writer, :actors, :plot,
            :poster, :imdb_id, to: :@movie

  def rating
    @movie.rated
  end

  def release_date
    Date.parse(@movie.released)
  end

  def runtime
    @movie.runtime.to_i
  end

  def imdb_rating
    (@movie.imdb_rating.to_f * 10).to_i
  end

  def imdb_votes
    @movie.imdb_votes.gsub(",", "").to_i
  end
end
