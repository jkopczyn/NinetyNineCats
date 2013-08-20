class CatRentalRequestsController < ApplicationController
  before_filter :require_user!, :only => [:approve, :deny]
  before_filter :require_cat_ownership!, :only => [:approve, :deny]

  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def create
    @rental_request = CatRentalRequest.create!(params[:cat_rental_request])
    redirect_to cat_url(@rental_request.cat)
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end

  private
  def current_cat_rental_request
    @rental_request ||= CatRentalRequest.includes(:cat).find(params[:id])
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def require_cat_ownership!
    redirect_to cat_url(current_cat) unless current_user.owns_cat?(current_cat)
  end
end
