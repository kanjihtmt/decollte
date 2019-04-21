class Admin::AdministratorsController < Admin::BaseController
  before_action :set_administrator, only: %i(edit update destroy)
  before_action :check_admin, only: %i(destroy)

  def index
    @administrators = Administrator.page(params[:page])
  end

  def new
    @administrator = Administrator.new
  end

  def edit
  end

  def create
    @administrator = Administrator.new(administrator_params)
    if @administrator.save
      redirect_to admin_administrators_path,
        notice: t(:create, scope: 'flash_message', model: Administrator.model_name.human)
    else
      render :new
    end
  end

  def update
    if @administrator.update(administrator_params)
      redirect_to admin_administrators_path,
        notice: t(:update, scope: 'flash_message', model: Administrator.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @administrator.destroy
    redirect_to admin_administrators_path,
      notice: t(:destroy, scope: 'flash_message', model: Administrator.model_name.human)
  end

  private

    def set_administrator
      @administrator = Administrator.find(params[:id])
    end

    def check_admin
      redirect_to admin_administrators_path, notice: t(:can_not_only_admin_user_error) if @administrator.admin? && Administrator.admin.count == 1
    end

    def administrator_params
      params.require(:administrator).permit(:username, :password, :role)
    end
end
