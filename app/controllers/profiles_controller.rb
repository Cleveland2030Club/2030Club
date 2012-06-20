class ProfilesController < ApplicationController

  before_filter :require_user

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
  end

  def update
  end

  def show
  end

end