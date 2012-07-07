class RegistrationsController < ApplicationController

  before_filter :require_no_or_admin_user, :only => [:new, :create, :review]

  def new
    @registration ||= Registration.new
    @error_messages = {}
  end

  def create
    @registration = Registration.new(params[:registration])

    if (@registration.save)
      registration_converter = ConvertsRegistrationToAccountInformation.new
      user = registration_converter.do_it(@registration)

      order_id = OrdersHelper.create_membership_order(user)
      session[:order_id] = order_id

      unless current_user
        redirect_to new_orders_path
      else
        if @current_user.admin?
          if (user.respond_to?(:activate_account!))
            if (user.activate_account!)
              redirect_to new_user_session_path,
                  :notice => "Thank you for becoming a member. Your registration has been a success! " +  
                  "Please log in to begin using the site."  
            end
            UserMailer.deliver_welcome_email(user)
          end
        end
      end
    else
      render :action => 'new'
    end

  end

end

