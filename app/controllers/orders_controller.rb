class OrdersController < ApplicationController

  def new
    # user = User.first
    # user.account.email = 'adomokos@gmail.com'
    # UserMailer.deliver_welcome_email(user)
    # session[:order_id] = 1
    @order = Order.find_by_id(session[:order_id])

    # Don't play with the URL
    raise "Invalid access, Order was not found for order_id: #{session[:order_id]}" if @order == nil

    render get_view_name(@order)
  end

  def checkout
    @order = Order.find_by_id(session[:order_id])
    @order_item = @order.order_items[0]
    @item = @order.items[0]
    @order_item.quantity = params[:quantity].to_i if @order.event_order?
    unless @order_item.valid?
      render get_view_name(@order)
      return
    end

    @order_item.save
    @order.amount = @order_item.quantity * @order_item.item.price

    setup_response = GATEWAY.setup_purchase(@order.paypal_amount,
      :ip => request.remote_ip,
      :return_url => url_for(:action => 'confirm', :only_path => false),
      :cancel_return_url => url_for(:action => 'index', :only_path => false),
      :description => @item.product_type+" -- "+@order.event.name+" -- qty: "+@order_item.quantity.to_s
    )

    @order.express_token = setup_response.token
    @order.save

    redirect_to GATEWAY.redirect_url_for(setup_response.token)
  end

  def confirm
    @order = Order.find_by_id(session[:order_id])
    
    redirect_to :action => 'new' and return unless params[:token]

    details_response = GATEWAY.details_for(params[:token])
          
    unless details_response.success?
      @message = details_response.message
      render :action => 'error'
      return
    end

    @address = details_response.address
  end

  def complete
    @order = Order.find_by_id(session[:order_id])

    purchase = GATEWAY.purchase(@order.paypal_amount,
      :ip => request.remote_ip,
      :payer_id => params[:payer_id],
      :token => params[:token]
    )

    unless purchase.success?
      @message = purchase.message
      render :action => 'error'
      return
    else
      # Save payer_id
      @order.express_payer_id = params[:payer_id]

      if (@order.event_order?)
        complete_event_order_and_redirect
        return
      end

      @order.complete = true
      @order.save
      session[:order_id] = nil

      user = @order.customer
        
      if (user.respond_to?(:activate_account!))
        if (user.activate_account!)
	      	redirect_to new_user_session_path,
							:notice => "Thank you for becoming a member. Your registration has been a success! " +  
    				  "Please log in to begin using the site."  
	      end
	      UserMailer.deliver_welcome_email(user)
      end
    end

    @events = Event.all
    @sponsored_events = Event.coming_soon.with_sponsor
    @unsponsored_events = @events - @sponsored_events
  end

  def complete_rsvp
    @order = Order.find_by_id(session[:order_id])

    @order_item = @order.order_items[0]
    @order_item.quantity = params[:quantity].to_i
    if @order_item.valid?
      @order_item.save

      complete_event_order_and_redirect
    else
      render get_view_name(@order)
    end
  end

private
  def complete_event_order_and_redirect
    @order.complete = true
    @order.save
    
    event = @order.items[0].product

    UserMailer.deliver_event_registration_email(@order.customer, event)
    session[:order_id] = nil

    redirect_to event_path(event),
          :notice => "Thank you for registering for this event."
  end
  
  def get_view_name(order)
    if (@order.event_order?)
      if (@order.amount == 0)
        return 'new_order_rsvp'
      else
        return 'new_order_event'
      end
    else
      return 'new_order_membership'
    end

    return nil
  end

end
