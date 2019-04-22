class ErrorsController < ApplicationController
  def not_found
    raise ActionController::RoutingError.new('Not found')
  end
end
