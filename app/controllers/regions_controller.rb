class RegionsController < ApplicationController

  def show
    @categories = Category.find(:all, :order => :name)
    @regions = Region.find(:all, :order => :name)
    @region = @regions.select { |region| region.id == params[:id].to_i }.first
    locations = @region.locations
    @participants = locations.map{ |location| location.participant }.uniq
  end

end