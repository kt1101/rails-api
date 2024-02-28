class ApplicationController < ActionController::API
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :authenticated

  def encode_token(id)
    payload = {
      user_id: id,
      exp: Time.now.to_i + 3600
    }
    JWT.encode(payload, 'my_secret')
  end

  def logged_in_token
    header = request.headers['Authorization']
    return if !header
    token = header.split(' ')[1]
    UserToken.find_by(token: token)
  end

  def current_user
    if decode_token
      user_id = decode_token[0]['user_id']
      @user = User.find(user_id)
    end
  end

  private

    def decode_token
      return if !logged_in_token.present?
      begin
        JWT.decode(logged_in_token.token, 'my_secret', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end

    def authenticated
      render json: { message: 'Please log in' }, status: :unauthorized unless current_user
    end

    def user_not_authorized
      render json: { message: 'You are not authorized to perform this action.' }, status: :unauthorized
    end

end
