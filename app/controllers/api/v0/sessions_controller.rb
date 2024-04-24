class Api::V0::SessionsController < ApplicationController

  def create
    if valid_user?
      render json: UserSerializer.new(@user), status: :ok
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Invalid credentials, try again", 400)).error, status: :bad_request
    end
  end

  def valid_user?
    @user = User.find_by(email: params[:email])
    @user.authenticate(params[:password])
  end
end
