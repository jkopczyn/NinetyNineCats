class CatsController < ApplicationController
  before_action :require_user!, :only => [:new, :create, :edit, :update]

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = current_user.cats.new(cat_params)
    @cat.save!

    redirect_to cat_url(@cat)
  end

  def edit
    # If the cat does not belong to current_user
    # this will raise a RecordNotFound error.
    @cat = current_user.cats.find(params[:id])
    render :edit
  end

  def update
    @cat = current_user.cats.find(params[:id])
    @cat.update_attributes!(cat_params)
    redirect_to cat_url(@cat)
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :name, :sex)
  end
end

