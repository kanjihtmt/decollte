class Admin::ShopsController < Admin::BaseController
  before_action :set_shop, only: %i(edit update destroy)
  before_action :set_brand
  before_action :authorize_shop, only: %i(new create)

  def index
    @shops = @brand.shops.order(position: :asc)
  end

  def new
    @shop = Shop.new
  end

  def edit
  end

  def create
    @shop = Shop.new(shop_params)
    if @shop.save
      redirect_to admin_brand_shops_path(@brand), notice: t(:create, scope: 'flash_message', model: Shop.model_name.human)
    else
      render :new
    end
  end

  def update
    if @shop.update(shop_params)
      redirect_to admin_brand_shops_path(@brand), notice: t(:update, scope: 'flash_message', model: Shop.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    @shop.destroy
    redirect_to admin_brand_shops_path(@brand), notice: t(:destroy, scope: 'flash_message', model: Shop.model_name.human)
  end

  private

    def set_brand
      @brand = Brand.find(params[:brand_id])
    end

    def set_shop
      @shop = Shop.find(params[:id])
      authorize @shop
    end

    def authorize_shop
      authorize Shop
    end

    def shop_params
      params.require(:shop).permit(:brand_id, :name)
    end
end
