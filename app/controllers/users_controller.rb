class UsersController < ApplicationController
  def create
    @user = User.create!(user_params)
    login_user!(@user)

    redirect_to cats_url
  end

  def new
    render :new
  end

    private
    def user_params
      params.require(:user).permit(:password, :user_name)
    end
end
