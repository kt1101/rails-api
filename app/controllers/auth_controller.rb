class AuthController < ApplicationController
  skip_before_action :authenticated, except: [ :logout ]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  def signup
    @user = User.new(user_params)
    @token = encode_token(user_id: @user.id)
    if @user.save
      render json: {
        user: UserSerializer.new(@user).serializable_hash
      }, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by!(email: login_params[:email])
    if @user.authenticate(login_params[:password])
      token = encode_token(@user.id)
      user_token = UserToken.create!(token: token, user_id: @user.id)
      user_token.save
      response.headers['Authorization'] = "Bearer #{token}"
      render json: {
        user: UserSerializer.new(@user).serializable_hash,
        token: token
      }, status: :accepted
    else
      render json: { message: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def logout
    if logged_in_token.destroy
      render json: { message: 'User logged out' }, status: :ok
    else
      render json: { message: 'User not logged out' }, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username)
    end

    def login_params
      params.require(:user).permit(:email, :password)
    end

    def handle_invalid_record(e)
      render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
    end
end
