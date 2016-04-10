class Movie < ApplicationRecord

  has_and_belongs_to_many :collections, uniq: true

  validates_presence_of :title, :imdb_id
  validates_uniqueness_of :imdb_id

  def self.import(imdb_id)
    Resque.enqueue(MoviesImporterJob, imdb_id)
  end

  def self.add_to_collection(collection_id, movie_id)
    collection = Collection.find(collection_id)
    movie = Movie.find(movie_id)

    collection.movies << movie
    Collection.increment_counter(:movies_count, collection.id)
  end

  def self.remove_from_collection(collection_id, movie_id)
    collection = Collection.find(collection_id)

    movie = collection.movies.find(movie_id)

    collection.movies.delete(movie)
    Collection.decrement_counter(:movies_count, collection.id)
  end
end
