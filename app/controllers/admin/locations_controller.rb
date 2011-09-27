class Admin::LocationsController < Admin::AdminController

  before_filter :set_participant

  def new
    @location = Location.new
  end

  def create
  end


  private

  def set_participant
    if params.has_key?(:participant_id)
      @participant = Participant.find(params[:participant_id])
    else
      redirect_to admin_participants_path
    end
  end

end
