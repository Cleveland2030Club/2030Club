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
end