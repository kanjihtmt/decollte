class ShopsController < ApplicationController
  before_action :set_brand

  def index
    @shops = @brand.shops.page(params[:page]).per(2)
  end

  private

    def set_brand
      @brand = Brand.find_by!(name: params[:brand])
    end
end
