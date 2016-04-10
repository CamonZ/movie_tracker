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
end
