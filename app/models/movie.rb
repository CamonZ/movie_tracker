class Movie < ApplicationRecord
  validates_presence_of :title, :imdb_id
end

