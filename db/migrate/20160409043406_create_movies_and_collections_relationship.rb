class CreateMoviesAndCollectionsRelationship < ActiveRecord::Migration[5.0]
  def change
    create_join_table :collections, :movies, column_options: { null: false } do |t|
      t.index [:movie_id, :collection_id], unique: true
      t.index [:collection_id, :movie_id], unique: true
    end
  end
end
