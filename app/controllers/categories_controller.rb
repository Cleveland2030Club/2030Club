class CategoriesController < ApplicationController

  def show
    @categories = Category.order(:name)
    @regions = Region.order(:name)
    @category = @categories.where(:id => params[:id].to_i).first
    @participants = Participant.where(:category_id => @category.id).order(:name)
  end

end