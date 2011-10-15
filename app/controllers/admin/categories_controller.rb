class Admin::CategoriesController < Admin::BaseController

  def new
    @category = Category.new(params[:category])
  end
end
