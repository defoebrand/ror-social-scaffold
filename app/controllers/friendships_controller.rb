class FriendshipsController < ApplicationController
  def create
    @friendship = Friendship.new(user_id: params[:user_id], friend_id: params[:friend_id], status: 'pending')

    if @friendship.save!
      redirect_to request.referrer
    end
  end

  def update
    @friend = Friendship.find(params[:id])
    @friend.status = params[:status]
    if @friend.save!
      redirect_to request.referrer
    end
  end

  # def reject
  #   @friend = Friendship.find(params[:id, :status])
  #   @friend.status = params[:status]
  #   if @friend.save!
  #     redirect_to request.referrer
  #   end
  # end

end