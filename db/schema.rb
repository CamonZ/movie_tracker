# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160415222726) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "collections", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "movies_count", default: 0
  end

  create_table "collections_movies", id: false, force: :cascade do |t|
    t.integer "collection_id", null: false
    t.integer "movie_id",      null: false
  end

  add_index "collections_movies", ["collection_id", "movie_id"], name: "index_collections_movies_on_collection_id_and_movie_id", unique: true, using: :btree
  add_index "collections_movies", ["movie_id", "collection_id"], name: "index_collections_movies_on_movie_id_and_collection_id", unique: true, using: :btree

  create_table "movies", force: :cascade do |t|
    t.string   "imdb_id"
    t.string   "title"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "year"
    t.string   "rating"
    t.date     "release_date"
    t.integer  "runtime"
    t.string   "genre"
    t.string   "director"
    t.string   "writer"
    t.string   "actors"
    t.text     "plot"
    t.integer  "imdb_rating"
    t.integer  "imdb_votes"
    t.string   "poster_location"
  end

end
