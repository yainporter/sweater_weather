class ApplicationController < ActionController::API
  rescue_from NoMethodError, with: :no_method_error

  def no_method_error(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400))
      .no_method_error, status: :bad_request
  end

  def authenticate_api_key
    begin
      api_key = params[:api_key]
      hashed_key = Digest::SHA256.hexdigest(api_key)
      @user = User.find_by(api_key_hash: hashed_key)
    rescue TypeError
      render json: ErrorSerializer.new(ErrorMessage.new("Unauthorized", 401)).error, status: :unauthorized
    end
  end
end
