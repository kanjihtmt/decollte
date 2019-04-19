class ShopsController < ApplicationController
  def index
    render plain: params[:brand]
  end
end
