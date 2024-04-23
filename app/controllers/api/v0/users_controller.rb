class Api::V0::UsersController < ApplicationController
rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  def create
    user = User.create!(user_params)

    render json: UserSerializer.new(user), status: :created
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def record_not_unique(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 409)).error, status: :conflict
  end
end
