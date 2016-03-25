class Api::V1::MoviesController < ::ApplicationController
  def index
    movies = Movie.all
    render json: movies
  end

  def show
    movie = Movie.find(params[:id])
    render json: movie
  end

  def import
    Movie.import(import_attributes)
    head :accepted
  end

  def update
    movie = Movie.find(params[:id])

    movie.update_attributes(movie_attributes)

    render json: movie, status: :accepted
  end

  def destroy
    Movie.delete(params[:id])
    head :accepted
  end

  private

  def import_attributes
    params.require(:movie).require(:imdb_id)
  end

  def movie_attributes
    params.require(:movie).permit(:title, :imdb_id)
  end
end
