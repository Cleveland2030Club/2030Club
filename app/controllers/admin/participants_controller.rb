class Admin::ParticipantsController < Admin::AdminController
  def index
    @participants = Participant.find(:all)
  end
end