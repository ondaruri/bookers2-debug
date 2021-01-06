class RerationshipsController < ApplicationController
  def follow
    @user = current_user
    current_user.follow(params[:id])
    redirect_to user_path(@user)
  end

  def unfollow
    @user = current_user
    current_user.unfollow(params[:id])
    redirect_to user_path(@user)
  end
end
