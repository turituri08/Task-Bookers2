class RelationshipsController < ApplicationController
  before_action :set_user, only: [:create, :destroy]

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'Followed the user'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = 'Failed to follow user'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'Unfollowed user'
      redirect_back(fallback_location: root_path)
    else
      flash.now[:alert] = 'Failed to unfollow user'
      redirect_back(fallback_location: root_path)
    end
  end

  def followings
    @user  = User.find(params[:id])
    @users = @user.followings
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:follow_id])
  end
end
