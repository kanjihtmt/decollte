class Admin::PasswordsController < Devise::RegistrationsController
  def new
    render plain: 'Password'
  end
end
