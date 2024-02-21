class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  skip_before_action :authorized, only: [ :create ]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  # GET /users
  def index
    render json: UserSerializer.new(current_user).serializable_hash, status: :ok
  end

  # GET /users/1
  def show
    render json: { user: UserSerializer.new(current_user).serializable_hash }, status: :ok
  end

  # POST /users
  def create
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

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  def update_avatar
    if current_user.image.attach(params[:file_path])
      current_user.update(avatar: url_for(current_user.image))
      if current_user.save
        render json: { user: UserSerializer.new(current_user).serializable_hash }, status: :ok
      end
    else
      render json: { errors: current_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :username)
    end

    def handle_invalid_record(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
