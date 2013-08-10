class CatsController < ApplicationController
  def create
    @cat = Cat.create!(params[:cat])
    redirect_to cat_url(@cat)
  end

  def edit
    @cat = Cat.find(params[:id])

    render :edit
  end

  def index
    @cats = Cat.all

    render :index
  end

  def new
    @cat = Cat.new

    render :new
  end

  def show
    @cat = Cat.find(params[:id])

    render :show
  end

  def update
    @cat = Cat.find(params[:id])
    @cat.update_attributes!(params[:cat])
    redirect_to cat_url(@cat)
  end
end
