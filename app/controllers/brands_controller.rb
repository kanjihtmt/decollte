class BrandsController < ApplicationController
  def index
    @brands = Brand.page(params[:page])
  end
end
