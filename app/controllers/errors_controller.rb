class ErrorsController < ApplicationController
  def not_found
    raise ActionController::RoutingError, 'Not found'
  end
end
