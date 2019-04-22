class ApplicationController < ActionController::Base
  include ErrorHandlers unless Rails.env.development?
end
