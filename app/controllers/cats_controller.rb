class CatsController < ApplicationController
  before_filter :require_cat_ownership!, :only => [:edit, :update]
  
  def create
    @cat = Cat.new(params[:cat])
    @cat.user_id = current_user.id
    @cat.save!

    redirect_to cat_url(@cat)
  end

  def edit
    # force evaluation of current_cat
    current_cat

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
    # force evaluation of current_cat
    current_cat

    render :show
  end

  def update
    current_cat.update_attributes!(params[:cat])
    redirect_to cat_url(@cat)
  end

  private
  include CatsHelper

  def require_cat_ownership!
    redirect_to cats_url unless current_user_owns_cat?
  end
end
