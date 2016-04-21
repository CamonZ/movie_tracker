class Api::V1::MoviesController < Api::AuthenticatedController

  def index
    movies = Movie.all
    render json: movies
  end

  def show
    movie = Movie.find(params[:id])
    render json: movie
  end

  def import
    Movie.import(*import_attributes)
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

  def add_to_collection
    Movie.add_to_collection(*movies_for_collection_attributes)
    head :accepted
  end

  def remove_from_collection
    Movie.remove_from_collection(*movies_for_collection_attributes)
    head :accepted
  end

  private

  def import_attributes
    { imdb_id: params.require(:movie).require(:imdb_id) }.merge( user_id: current_resource_owner.id ).values
  end

  def movie_attributes
    params.require(:movie).permit(:title, :imdb_id)
  end

  def movies_for_collection_attributes
    params.require([:collection_id, :movie_id])
  end
end
