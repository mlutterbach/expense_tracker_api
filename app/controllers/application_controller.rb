class ApplicationController < ActionController::API
  def encode_token(payload)
    JWT.encode(payload, Rails.application.secret_key_base)
  end

  def decode_token
    auth_header = request.headers['Authorization']
    return nil unless auth_header

    token = auth_header.split(' ')[1]
    begin
      JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256')[0]
    rescue JWT::DecodeError
      nil
    end
  end

  def logged_in_user
    decoded_token = decode_token
    @current_user ||= User.find_by(id: decoded_token['user_id']) if decoded_token
  end

  def authorize
    render json: { error: 'Unauthorized' }, status: :unauthorized unless logged_in_user
  end
end
