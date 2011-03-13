class MembersController < ApplicationController
  def index
#    @members = User.all_members
#		@members = User.paginate_all_by_last_name params[:search], :page => params[:page], :order => 'first_name ASC'
#    @members = User.paginate_all_by_active true, :page => params[:page], :order => 'first_name ASC'
    @members = User.search_active(params[:search],@date,params[:page])
#    logger.info("I am in index")
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
