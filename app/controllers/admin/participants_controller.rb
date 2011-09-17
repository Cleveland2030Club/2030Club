class Admin::ParticipantsController < Admin::AdminController
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
      flash[:message] = "Participant has been registered."
      redirect_to admin_participant_path(@participant)
    else
      render 'new'
    end
  end
end