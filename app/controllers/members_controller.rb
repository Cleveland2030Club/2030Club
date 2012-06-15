class MembersController < ApplicationController
  def index
    @members = User.search_active(params[:search],@date,params[:page])
	end	

  def show
    @member = User.find_by_id(params[:id])
    @events = @member.attendance
  end
  
  def edit
    if current_user.id == params[:id].to_i
    	@member = current_user
		elsif current_user.admin?
		  @member = User.find(params[:id])
		else
			redirect_to new_user_session_path
  	end
  end
  
  def update
    if current_user.id == params[:id].to_i
      @member = current_user
    elsif current_user.admin?
      @member = User.find(params[:id])
    end
    if @member.update_attributes(params[:user])
      redirect_to member_url(@member)
    else
      render :action => :edit
    end
  end
  
  def edit_login
    edit
  end

  def search
    @members = User.all_members
	end
  
end
