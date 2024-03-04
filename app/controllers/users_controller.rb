class UsersController < ApplicationController
  before_action :set_user
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  # GET /users/1
  def show
    authorize(@user)
    render json: { user: UserSerializer.new(@user).serializable_hash }, status: :ok
  end

  # PATCH/PUT /users/1
  def update
    authorize(@user)
    if @user.update(user_params)
      render json: UserSerializer.new(@user).serializable_hash, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :username, :avatar)
  end

  def handle_invalid_record(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end
