class Api::V0::SessionsController < ApplicationController
  before_action :authenticate_user

  def create
    render json: UserSerializer.new(@user), status: :ok
  end

  def authenticate_user
    @user = User.find_by(email: params[:email])
    @user.authenticate(params[:password])
  end
end
