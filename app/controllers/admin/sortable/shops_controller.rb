class Admin::Sortable::ShopsController < ApplicationController
  before_action :set_brand

  def update
    @shop = @brand.shops.find(params[:id])
    @shop.insert_at(params[:to].to_i + 1)
    head :ok
  end

  private

    def set_brand
      @brand = Brand.find(params[:brand_id])
    end
end
