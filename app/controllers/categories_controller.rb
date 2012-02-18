class CategoriesController < ApplicationController

  def show
    @categories = Category.find(:all, :order => :name)
    @regions = Region.find(:all, :order => :name)
    @category = @categories.select { |category| category.id == params[:id].to_i }.first
    @participants = Participant.find(:all, :conditions =>{ :category_id => @category.id }, :order => :name)
  end

end