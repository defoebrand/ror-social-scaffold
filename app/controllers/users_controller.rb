class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @friendships = Friendship.all
    @friendship = Friendship.new
    @friends = @friendships.select { |x| x.user_id == current_user.id }
    @friend_requests = @friendships.select { |x| x.friend_id == current_user.id }
    # @not_friends = @users.each do |x|
    #   if x.id != current_user.id
    #     if @friends.empty?
    #       x.id
    #     else
    #       @friends.each do |y|
    #         x.id unless x.id == y.friend_id
    #       end
    #     end
    #   end
    # end
    # @user = current_user
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friendship = Friendship.new
    @friendships = Friendship.all
    @friends = @friendships.select { |x| x.user_id == current_user.id }
  end

  def friend_requests
    @friendship = Friendship.create(friend_params)

    redirect_to request.referrer
  end

  private

  def friend_params
    params.require(:friendship).permit(:friend_id, :user_id, :status)
  end
end
