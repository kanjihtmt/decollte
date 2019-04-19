class Admin::SessionsController < Devise::SessionsController
  layout 'admin_auth'

  protected

    def after_sign_in_path_for(_resource)
      admin_root_path
    end

    def after_sign_out_path_for(_resource)
      admin_login_path
    end
end
