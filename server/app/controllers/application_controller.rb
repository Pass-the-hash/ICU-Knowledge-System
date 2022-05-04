class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def not_found

  end
  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = Worker.find(@decoded[:user_id])
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end
