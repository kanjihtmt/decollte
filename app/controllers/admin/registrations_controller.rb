class Admin::RegistrationsController < Devise::RegistrationsController
  def new
    render plain: 'Registrations'
  end
end
