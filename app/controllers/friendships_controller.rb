class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id], status: 'pending')

    redirect_to request.referrer if @friendship.save!
  end

  def update
    @friend = Friendship.find(params[:id])
    @friend.status = params[:status]
    @friendship = Friendship.create(user_id: params[:friend_id], friend_id: params[:user_id], status: 'confirmed')
    redirect_to request.referrer if @friend.save!
  end
end
