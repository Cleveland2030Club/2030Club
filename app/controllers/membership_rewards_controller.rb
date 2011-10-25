class MembershipRewardsController < ApplicationController

  def index
    @categories = Category.find(:all, :order => :name)
    @participants = Participant.find(:all, :order => :name)
  end

end