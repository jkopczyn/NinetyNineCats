class CatRentalRequestsController < ApplicationController
  def approve
    @rental_request = CatRentalRequest.find(params[:id])
    @rental_request.approve!

    redirect_to cat_url(@rental_request.cat_id)
  end

  def create
    @rental_request = CatRentalRequest.create!(params[:cat_rental_request])
    redirect_to cat_url(@rental_request.cat)
  end

  def deny
    @rental_request = CatRentalRequest.find(params[:id])
    @rental_request.deny!

    redirect_to cat_url(@rental_request.cat_id)
  end

  def new
    @rental_request = CatRentalRequest.new
  end
end
