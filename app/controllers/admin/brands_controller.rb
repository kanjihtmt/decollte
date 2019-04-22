class Admin::BrandsController < Admin::BaseController
  def index
    @brands = Brand.page(params[:page])
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      redirect_to admin_brands_path,
        notice: t(:create, scope: 'flash_message', model: Brand.model_name.human)
    else
      render :new
    end
  end

  private

    def brand_params
      params.require(:brand).permit(:name)
    end
end
