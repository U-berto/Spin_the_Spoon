class UsersController < ApplicationController
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to params[:user][:redirect]
    else
      render :update
    end
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
