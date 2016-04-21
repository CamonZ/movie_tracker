class Api::AuthenticatedController < ApplicationController
  before_action -> { doorkeeper_authorize! :public }
end
