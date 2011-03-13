#require 'fastercsv'
class ReportsController < ApplicationController

  before_filter :requires_admin, :except => []
  BOM = "\377\376"
  
  def index
    @date = params[:yr] +"-"+ params[:mo] if params[:yr] and params[:mo]
    unless params[:activated]
      @members = User.search(params[:search],@date,params[:page])
      @csv_members = User.csv_search(params[:search],@date)
    else
      @members = User.search_active(params[:search],@date,params[:page])
      @csv_members = User.csv_search_active(params[:search],@date)
    end
    respond_to do |format|
      format.html
      # format.csv { 
      #         filename = I18n.l(Time.now, :format => :short) + "- Members.csv"
      #         content = FasterCSV.generate do |csv|
      #           csv << [
      #             "First Name",
      #             "Last Name",
      #             "Activated",
      #             "Member Since",
      #             "Last Renewal",
      #             "Email"
      #           ]
      #           @csv_members.each do |user|
      #             csv << [
      #               user.first_name,
      #               user.last_name,
      #               user.activated,
      #               user.joined_at,
      #               user.activated_at,
      #               user.email
      #             ]
      #           end
      #         end
      #         content = BOM + Iconv.conv("utf-16le", "utf-8", content)
      #         send_data content, :filename => filename
      }
    end
	end	

  def show
    @member = User.find_by_id(params[:id])
  end
  
  def edit
  	if current_user
    	@member = current_user
		else
			redirect_to new_user_session_path
  	end
  end
  
  def update

    @member = current_user
    
    if @member.update_attributes(params[:user])
      redirect_to member_url(current_user.id)
    else
      render :action => :edit
    end
  end
  
end
