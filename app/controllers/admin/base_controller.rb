class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_admin_administrator!

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:username, :password, :password_confirmation) }
      devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:username, :password, :password_confirmation) }
    end

    def authenticate_admin_administrator!
      if admin_administrator_signed_in?
        super
      else
        redirect_to admin_login_path
      end
    end
end
