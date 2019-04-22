module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from Exception, with: :rescue500
    rescue_from ActionController::RoutingError, with: :rescue404
    rescue_from ActiveRecord::RecordNotFound, with: :rescue404
  end

  private

    def rescue404(e)
      render 'errors/not_found', status: :not_found
    end

    def rescue500(e)
      binding.pry
      # SentryもしくはBagsnagでエラー通知させる
      render 'errors/internal_server_error', status: :internal_server_error
    end
end
