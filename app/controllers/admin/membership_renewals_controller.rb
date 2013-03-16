module Admin
  class MembershipRenewalsController < Admin::BaseController

    def create
      @user = User.find(params[:user_id])
      @user.update_membership_expiration(renew_date)
      redirect_to admin_user_path(@user)
    end

    protected

    def renew_date
      if params[:renew_date].blank?
        Time.now
      else
        params[:renew_date]
      end
    end

  end
end