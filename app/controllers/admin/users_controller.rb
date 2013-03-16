module Admin
  class UsersController < Admin::BaseController

    def index
      @users = User.all
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
    end

    def edit
    end

    def update
    end

    def destroy
    end

  end
end