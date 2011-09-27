class Admin::LocationsController < Admin::AdminController

  def new
    @participant = Participant.find(params[:participant_id])
    @location = Location.new
  end

  def create
    @participant = Participant.find(params[:participant_id])
  end

end
