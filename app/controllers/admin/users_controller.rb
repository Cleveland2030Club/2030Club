module Admin
  class UsersController < Admin::BaseController
    # TODO: ALL THESE ROUTES NEED TESTS

    def index
      @users = User.all
      @active_user_count = User.where(activated: true, active: true).where("expired_at > ?", Time.now).count
    end

    def new
      @user = User.new
    end

    def create
      @user = User.new(params[:user])

      if @user.save
        @user.activate_account!

        UserMailer.welcome_email(@user).deliver

        redirect_to admin_users_path
      else
        render :new
      end
    end

    def show
      @user = User.find(params[:id])
    end

    def edit
    end

    def update
    end

    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path
    end

    def search
      @user = User.where(email: params[:email].downcase).pop
      if @user
        render :show
      else
        redirect_to admin_users_path, notice: "Could not find a user with #{params[:email]}"
      end
    end

  end
end
