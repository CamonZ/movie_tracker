class Movie < ApplicationRecord

  validates_presence_of :title, :imdb_id
  validates_uniqueness_of :imdb_id

  def self.import(imdb_id)
    Resque.enqueue(MoviesImporterJob, imdb_id)
  end
end

