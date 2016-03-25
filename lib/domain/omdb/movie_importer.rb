class MovieImporter

  def import(imdb_id)
    create_movie_from fetched_movie(imdb_id)
  end

  def fetched_movie(imdb_id)
    OMDB.id(imdb_id)
  end

  private

  def wrapped_attributes(fetched_movie)
    MovieWrapper.new(fetched_movie).attributes
  end

  def create_movie_from(fetched_movie)
    movie = Movie.new(wrapped_attributes(fetched_movie))
    movie.save!
  end
end
