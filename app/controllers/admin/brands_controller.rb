class Admin::BrandsController < Admin::BaseController
  def index
  end

  def show
    @brand = Brand.find(params[:id])
  end

  def new
  end

  def create
  end
end
