class Api::V1::CollectionsController < ApplicationController
  def index
    collections = Collection.all
    render json: collections, each_serializer: CollectionDigestSerializer
  end

  def show
    collection = Collection.find(params[:id])
    render json: collection
  end

  def create
    collection = Collection.new(collection_attributes)
    collection.save

    head :created, location: api_v1_collection_path(collection)
  end

  def update
    collection = Collection.find(params[:id])

    collection.update_attributes(collection_attributes)

    render json: collection, status: :accepted
  end

  def destroy
    Collection.destroy(params[:id])
    head :accepted
  end


  private

  def collection_attributes
    params.require(:collection).permit(:title, :description)
  end
end
