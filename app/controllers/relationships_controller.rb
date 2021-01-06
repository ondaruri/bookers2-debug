class RelationshipsController < ApplicationController
  def follow
    @user = current_user
    current_user.follow(params[:id])
    redirect_to request.referer
  end

  def unfollow
    @user = current_user
    current_user.unfollow(params[:id])
    redirect_to request.referer
  end
end
