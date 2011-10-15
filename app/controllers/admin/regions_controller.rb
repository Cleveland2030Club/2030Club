class Admin::RegionsController < Admin::BaseController

  def new
    @region = Region.new(params[:region])
  end

  def create
    @region = Region.new(params[:region])
    if @region.save
      flash[:notice] = "Thank you for adding a new region!"
      redirect_to admin_participants_path
    else
      render :new
    end
  end

  def edit
    @region = Region.find(params[:id])
  end

  def update
    @region = Region.find(params[:id])
    if @region.update_attributes(params[:region])
      flash[:notice] = "Region has been updated!"
      redirect_to admin_participants_path
    else
      render :edit
    end
  end

  def destroy
    @region = Region.find(params[:id])
    @region.destroy
    redirect_to admin_participants_path
  end

end
