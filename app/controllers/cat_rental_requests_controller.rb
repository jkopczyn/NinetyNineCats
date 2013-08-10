class CatRentalRequestsController < ApplicationController
  def create
    @rental_request = CatRentalRequest.create!(params[:cat_rental_request])
    redirect_to cat_url(@rental_request.cat)
  end

  def new
    @rental_request = CatRentalRequest.new
  end
end
