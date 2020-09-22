class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    friend_list = []
    friends = Friendship.all.select do |x|
      (x.user_id == current_user.id) ||
        (x.friend_id == current_user.id)
    end
    friends.each do |x|
      friend_list << x.user_id
      friend_list << x.friend_id
    end
    @timeline_posts ||= Post.all.where(user_id: friend_list).ordered_by_most_recent.includes(:user)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
