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
      @board_term = BoardTerm.new(params[:board_term])
      if @user.board_terms << @board_term
        redirect_to admin_user_path(@user), notice: "Board Service has been added"
      else
        render :new
      end
    end

    def update
      @board_term = @user.board_terms.find(params[:id])
      if @board_term.update_attributes(params[:board_term])
        redirect_to admin_user_path(@user), notice: "Board Service has been updated"
      else
        render :edit
      end
    end

    def destroy
      @board_term = @user.board_terms.find(params[:id])
      @board_term.destroy
      redirect_to admin_user_path(@user)
    end

    protected

    def set_user
      @user = User.includes(:board_terms).find(params[:user_id])
    end

  end
end