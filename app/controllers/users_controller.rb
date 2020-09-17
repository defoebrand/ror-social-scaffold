class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friendships = Friendship.all
    @friendship = Friendship.new
    # @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
  end

  def friend_requests
    @friendship = Friendship.create(friend_params)

    redirect_to users_url
  end

  private

  def friend_params
    params.require(:friendship).permit(:friend_id, :user_id, :status)
  end
end
