class UsersController < ApplicationController

  before_filter :require_no_or_admin_user, :only => [:new, :create, :forgotten]
  before_filter :require_user, :only => [:show, :edit, :update, :renewal]

  def new
    @user = User.new
    @user.build_user_address
    @user.build_user_profile
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      order_id = OrdersHelper.create_membership_order(@user)
      session[:order_id] = order_id

      redirect_to new_orders_path
    else
      render :new
    end
  end

  def show
    @user = current_user
    @events = Event.coming_soon
    @sponsored_events = @events.with_sponsor
    @unsponsored_events = @events - @sponsored_events
  end

  def edit
    @user = @current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to user_url
      flash[:notice] = "Thank you for updating your account."
    else
      render :action => :edit
    end
  end

  def renewal
    @membership_status = MembershipStatus.new(current_user).status
    session[:order_id] = OrdersHelper.create_membership_order(current_user)
    render :action => "renewal"
  end


private

  def valid_email?(email)
    email =~ RegistrationsHelper::EMAIL_REGEX
  end

end
