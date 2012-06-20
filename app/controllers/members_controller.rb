class MembersController < ApplicationController

  def index
    @members = User.search_active(params[:search],@date,params[:page])
	end	

  def show
    @member = User.find_by_id(params[:id])
    @events = @member.attendance
  end
  
  def search
    @members = User.all_members
	end

  private

  def set_member
    return @member = current_user if current_user.id == params[:id].to_i
    return @member = User.find(params[:id]) if current_user.admin?
  end
  
end
