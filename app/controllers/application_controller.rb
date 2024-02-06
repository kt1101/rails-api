class ApplicationController < ActionController::API
  before_action :authorized

  def encode_token(id)
    payload = {
      user_id: id,
      exp: Time.now.to_i + 3600
    }
    JWT.encode(payload, 'my_secret')
  end

  def decode_token
    header = request.headers['Authorization']
    if header
      token = header.split(' ')[1]
      begin
        JWT.decode(token, 'my_secret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def destroy_token
    if current_user
      @user = nil
      decode_token[0]["exp"] = Time.now.to_i
    else
      render json: { message: 'No user logged in' }, status: :unauthorized
    end
  end

  def current_user
    if decode_token
      user_id = decode_token[0]['user_id']
      @user = User.find(user_id)
    end
  end

  def authorized
    debugger
    render json: { message: 'Please log in' }, status: :unauthorized unless current_user
  end

end
