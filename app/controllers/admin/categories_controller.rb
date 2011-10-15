class Admin::CategoriesController < Admin::BaseController

  def new
    @category = Category.new(params[:category])
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "Thank you for adding a new category!"
      redirect_to admin_participants_path
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

end
