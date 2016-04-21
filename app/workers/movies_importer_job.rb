require 'omdbapi'
require "#{Rails.root}/lib/domain/omdb/movie_importer.rb"

class MoviesImporterJob
  @queue = :movies_importer

  def self.perform(imdb_id, user_id)
    new.import(imdb_id, user_id)
  end

  def import(imdb_id, user_id)
    begin
      importer.import(imdb_id, user_id)
    rescue ActiveRecord::RecordInvalid
    end
  end


  def importer
    MovieImporter.new
  end
end
