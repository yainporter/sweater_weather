class Api::V0::SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: UserSerializer.new(user), status: :ok
    else
      render json: { status: 'error', message: 'Invalid credentials' }, status: :unauthorized
    end
  end
end
