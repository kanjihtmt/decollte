class Admin::BaseController < ApplicationController
  include Pundit
  layout 'admin'

  rescue_from Pundit::NotAuthorizedError, with: :rescue403

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

    def pundit_user
      current_admin_administrator
    end

    def rescue403
      redirect_to admin_root_path, alert: t(:authorized_error)
    end
end
