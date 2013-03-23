module Admin
  class BoardTermsController < Admin::BaseController

    before_filter :set_user

    def new
      @board_term = @user.board_terms.new(params[:board_term])
    end

    def edit
      @board_term = @user.board_terms.find(params[:id])
    end

    def create
    end

    def update
    end

    def destroy
    end

    protected

    def set_user
      @user = User.includes(:board_terms).find(params[:user_id])
    end

  end
end