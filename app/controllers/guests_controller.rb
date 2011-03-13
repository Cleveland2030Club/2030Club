class GuestsController < ApplicationController

  def create
    @guest = Guest.new(params[:guest])
    @event = Event.find(params[:event_id])
    if @guest.save
      order_id = OrdersHelper.create_event_order(@guest, @event)
      session[:order_id] = order_id
      redirect_to new_orders_path
    else
      render 'app/views/events/show.html.erb'
      flash[:notice] = "Please fix the errors and try again."
    end
  end

end
