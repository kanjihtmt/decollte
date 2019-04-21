class Admin::AdministratorsController < Admin::BaseController
  before_action :set_administrator, only: %i(edit update destroy)
  before_action :check_super_admin, only: %i(destroy)

  def index
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

    def set_administrator
      @administrator = Administrator.find(params[:id])
    end

    def check_admin
    end
end
