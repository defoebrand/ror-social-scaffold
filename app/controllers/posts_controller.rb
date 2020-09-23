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
    view_posts_of = [current_user.id]
    friends = Friendship.all.select do |x|
      (x.user_id == current_user.id) ||
        (x.friend_id == current_user.id)
    end
    friends.each do |x|
      if x.status == 'confirmed'
        view_posts_of << x.user_id
        view_posts_of << x.friend_id
      end
    end
    @timeline_posts ||= Post.all.where(user_id: view_posts_of).ordered_by_most_recent.includes(:user)
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
