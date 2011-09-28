class Admin::LocationsController < Admin::AdminController

  before_filter :set_participant

  def new
    @location = Location.new
  end

  def create
    @location = @participant.locations.build(params[:location])
    if @location.save
      flash[:notice] = "Thank you for adding the location"
      redirect_to admin_participant_path(@participant)
    else
      render :new
    end
  end

  def edit
    @location = @participant.locations.find(params[:id])
  end

  def update
    @location = @participant.locations.find(params[:id])
    if @location.update_attributes(params[:location])
      flash[:notice] = "Location has been updated"
      redirect_to admin_participant_path(@participant)
    else
      render :edit
    end
  end

  def destroy
    @location = @participant.locations.find(params[:id])
    @location.destroy
    redirect_to admin_participant_path(@participant)
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
