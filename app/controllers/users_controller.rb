class UsersController < ApplicationController
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to params[:user][:redirect]
    else
      render :update
    end
  end

  def signout
    sign_out current_user
    redirect_to new_user_session_path
  end

  private

  def user_params
    params.require(:user).permit(:username)
  end
end
