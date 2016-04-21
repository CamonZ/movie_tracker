class ApplicationController < ActionController::API

  include ActionController::Serialization

  rescue_from ActiveRecord::RecordNotFound do
    head :not_found
  end

  rescue_from ArgumentError do
    head :bad_request
  end

  rescue_from ActionController::ParameterMissing do |e|
    render json: { errors: { missing_parameter: [e.param] } }, status: :bad_request
  end

  rescue_from ActiveRecord::RecordNotUnique do
    head :unprocessable_entity
  end

  protected

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
