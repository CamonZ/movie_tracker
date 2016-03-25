class AddMissingMovieFields < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :year, :integer
    add_column :movies, :rating, :string
    add_column :movies, :release_date, :date
    add_column :movies, :runtime, :integer
    add_column :movies, :genre, :string
    add_column :movies, :director, :string
    add_column :movies, :writer, :string
    add_column :movies, :actors, :string
    add_column :movies, :plot, :text
    add_column :movies, :imdb_rating, :integer
    add_column :movies, :imdb_votes, :integer
    add_column :movies, :poster_location, :string
  end
end
