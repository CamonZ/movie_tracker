class AddUserIdToMoviesAndCollections < ActiveRecord::Migration[5.0]
  def change
    add_reference :movies, :user, index: true
    add_reference :collections, :user, index: true
  end
end
