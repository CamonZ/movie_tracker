class Api::V1::MoviesController < ::ApplicationController
  def index
    movies = Movie.all
    render json: movies
  end

  def show
    movie = Movie.find(params[:id])
    render json: movie
  end

  def create
    movie = Movie.create(movie_attributes)

    if movie.persisted?
      render json: movie, status: :created
    else
      render json: { errors: movie.errors }, status: :bad_request
    end
  end

  def update
    movie = Movie.find(params[:id])

    movie.update_attributes(movie_attributes)

    render json: movie, status: :accepted
  end

  def destroy
    Movie.delete(params[:id])
    render nothing: true, status: :accepted
  end

  private

  def movie_attributes
    params.require(:movie).permit(:title, :imdb_id)
  end
end
