class Api::V0::UsersController < ApplicationController
rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique
rescue_from ActiveRecord::NotNullViolation, with: :not_null_violation
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  def create
    user = User.create!(user_params)
    render json: UserSerializer.new(user), status: :created
  end

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def record_invalid(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422)).error, status: :unprocessable_entity
  end
end
