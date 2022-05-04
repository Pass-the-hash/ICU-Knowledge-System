class AuthenticationController < ApplicationController
  # before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    @user = Worker.find_by username: login_params[:username]
    if @user&.authenticate(login_params[:password])
      token = JsonWebToken.encode(user_id: @user._id)
      # time = Time.now + 24.hours.to_i
      # exp: time.strftime("%m-%d-%Y %H:%M"),
      render json: { token: token, id: @user._id.to_s }, status: :ok
    else
      render json: { error: 'Login failed' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:username, :password)
  end
end
