class Admin::ParticipantsController < Admin::BaseController

  before_filter :get_categories, :except => [:destroy, :show]

  def index
    @participants = Participant.find(:all)
  end

  def new
    @participant = Participant.new
  end

  def show
    @participant = Participant.find(params[:id])
  end

  def create
    @participant = Participant.new(params[:participant])
    if @participant.save
      flash[:notice] = "Participant has been registered."
      redirect_to admin_participant_path(@participant)
    else
      render 'new'
    end
  end

  def edit
    @participant = Participant.find(params[:id])
  end

  def update
    @participant = Participant.find(params[:id])
    if @participant.update_attributes(params[:participant])
      flash[:notice] = "Participant updated successfully."
      redirect_to admin_participant_path(@participant)
    else
      render 'edit'
    end
  end

  def destroy
    @participant = Participant.find(params[:id])
    @participant.destroy
    redirect_to admin_participants_path
  end

  protected

  def get_categories
    @categories = Category.all
  end

end
