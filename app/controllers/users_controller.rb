class UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  skip_before_action :authorized, only: [ :create ]
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  # GET /users
  def index
    @users = User.all

    render json: UserSerializer.new(@users).serializable_hash, status: :ok
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
      debugger
      render json: {
        user: UserSerializer.new(@user).serializable_hash,
        token: @token
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def handle_invalid_record(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
