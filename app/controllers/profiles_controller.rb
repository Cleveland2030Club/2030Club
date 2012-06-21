class ProfilesController < ApplicationController

  before_filter :require_user
  before_filter :verify_owner, :only => [:edit, :create]

  def new
    @profile = UserProfile.new(params[:user_profile])
  end

  def create
    @profile = UserProfile.new(params[:user_profile])
    @profile.user = current_user
    if @profile.save
      flash[:notice] = "Thank you for creating your profile"
      redirect_to user_path
    else
      render :new
    end
  end

  def edit
    @profile = UserProfile.find(params[:id])
  end

  def update
    @profile = UserProfile.find(params[:id])
    if @profile.update_attributes(params[:user_profile])
      flash[:notice] = "Thank you for editing your profile"
      redirect_to user_path
    else
      render :edit
    end
  end

  private

  def verify_owner
    unless current_user.user_profile.id == params[:id].to_i
      redirect_to new_user_sessions_path
    end
  end

end