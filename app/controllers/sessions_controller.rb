class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { user: user, token: token }, status: :ok
    else
      render json: { error: 'Invalid Credentials' }, status: :unauthorized
    end
  end
end
