class ApplicationController < ActionController::API
  include ActionController::Serialization

  rescue_from ActiveRecord::RecordNotFound do
    render nothing: true, status: :not_found
  end
end
