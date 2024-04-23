class ApplicationController < ActionController::API
  rescue_from NoMethodError, with: :no_method_error

  def no_method_error(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400))
      .no_method_error, status: :bad_request
  end
end
