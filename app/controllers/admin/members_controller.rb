class Admin::MembersController < Admin::BaseController
  def index
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save

    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
