class UserSessionsController < ApplicationController

  before_filter :require_no_or_admin_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    
    @user_session.validate
    if (@user_session.valid?)
      user = User.find_by_email(@user_session.email)
      if user.activated? == false
        set_order_id_in_session(user)

        redirect_to new_orders_path, :notice => "You need to activate your account!"
        return
      end
    end
    
    if @user_session.save
      redirect_back_or_default user_url
    else
      render :action => :new
    end
  end

  def show
  end

  def destroy
    current_user_session.destroy
    redirect_back_or_default new_user_session_url
  end  

private

  def set_order_id_in_session(user)
    # find the order
    order = Order.find_by_customer_id(user.id)
    if (order == nil)
      order_id = OrdersHelper.create_membership_order(user)
    else
      order_id = order.id
    end
        
    session[:order_id] = order_id
  end
end
