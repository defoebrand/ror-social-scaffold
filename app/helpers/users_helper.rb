module UsersHelper
  def friendship_exists?(user)
    
  end

  def friend_status(user)
    @status = content_tag(:div)
    unless @friends.any? {|f| f.friend_id == user.id or f.user_id == user.id}
      @status << button_to('Request', {:controller => 'friendships', 
        :action => 'create', 
        :user_id => current_user.id, 
        :friend_id => user.id,
        }, :method => :post)
      @status.html_safe
    else 
      friend = Friendship.find_by(friend_id: current_user.id, user_id: user.id )
      if friend and friend.status == 'pending'
        @status << button_to('Accept', {:controller => 'friendships', 
          :action => 'update', 
          :id => friend.id,   
          :status => 'confirmed'
          }, :method => :put)

        @status << button_to('Reject', {:controller => 'friendships', 
          :action => 'update', 
          :id => friend.id,   
          :status => 'denied'
          }, :method => :put)
      elsif friend && (friend.status == 'denied' || friend.status == 'confirmed')
        @status << content_tag(:p, friend.status)
      else  
        friend = Friendship.find_by(friend_id: user.id, user_id: current_user.id)
        if friend
          @status << content_tag(:p, friend.status)
        end
      end
    end
    @status.html_safe


  end

end

