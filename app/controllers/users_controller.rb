class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @others = @users.reject { |f| f.id == current_user.id }
    @friendships = Friendship.all
    @friendship = Friendship.new
    @friends = @friendships.select { |x| (x.user_id == current_user.id) || (x.friend_id == current_user.id) }
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friendship = Friendship.new
    @friendships = Friendship.all
    @friends = @friendships.select { |x| (x.user_id == current_user.id) || (x.friend_id == current_user.id) }
  end

  private

  def friend_params
    params.require(:friendship).permit(:id, :friend_id, :user_id, :status)
  end
end
