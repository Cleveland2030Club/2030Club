class EventsController < ApplicationController

  def show
    @event = Event.find(params[:id])
    @guest = Guest.new(params[:guest])

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @event }
    end
  end

  def register_member
    raise(ArgumentError, "Invalid Access") if current_user.nil?
    @event = Event.find(params[:event_id])
    order_id = OrdersHelper.create_event_order(current_user, @event)
    session[:order_id] = order_id
    redirect_to new_orders_path
  end

end
