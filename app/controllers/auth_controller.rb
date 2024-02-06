class AuthController < ApplicationController
  skip_before_action :authorized, only: [ :login ]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  def login
    @user = User.find_by!(email: login_params[:email])
    if @user.authenticate(login_params[:password])
      token = encode_token(@user.id)
      render json: {
        user: UserSerializer.new(@user).serializable_hash,
        token: token
      }, status: :accepted
    else
      render json: { message: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def logout
    destroy_token
    render json: { message: 'User logged out' }, status: :ok
  end

  private

  def login_params
    params.require(:user).permit(:email, :password)
  end
  def handle_invalid_record(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end
