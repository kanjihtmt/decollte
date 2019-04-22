class BrandsController < ApplicationController
  after_action :brands?

  def index
    @brands = Brand.page(params[:page])
  end

  private

    def brands?
      raise ActiveRecord::RecordNotFound if @brands.blank?
    end
end
