class BrandsController < ApplicationController
  after_action :have_brands?

  def index
    @brands = Brand.page(params[:page])
  end

  private

    def have_brands?
      raise ActiveRecord::RecordNotFound if @brands.blank?
    end
end
