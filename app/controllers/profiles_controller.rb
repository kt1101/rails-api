class ProfilesController < ApplicationController
  before_action :set_profile, only: [:update]

  def search
    @profiles = Profile.search(params[:query], { sort: ['updated_at:desc'] })
    render json: @profiles.raw_answer['hits'], status: :ok
  end

  def update
    authorize(@profile)
    if @profile.update(profile_params)
      @profile.index!
      render json: @profile, status: :ok
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(:name, :email)
  end
end
