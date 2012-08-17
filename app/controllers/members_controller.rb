class MembersController < ApplicationController

  def index
    @members = User.search_active(params[:search],@date,params[:page])
	end	

  def show
    @member = User.find_by_id(params[:id])
    @events = @member.attendance
  end

  def update
    @member = User.find(params[:id])
    if @member.update_attributes(params[:user])
      redirect_to member_path(@member)
    else
      flash[:error] = "The member was not updated...oops"
      redirect_to member_path(@member)
    end
  end
  
  def search
    @members = User.all_members
	end

end
