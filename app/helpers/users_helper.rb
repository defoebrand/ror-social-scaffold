module UsersHelper

  def friend_status_index(user)
    @status = tag(:div, class: 'status-btn-tag')
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
    @status
  end


  def friend_request_show(user)
    friendship_status = Friendship.find_by(friend_id: user.id)
    @status = tag(:div)
    unless friendship_status
      @status << button_to('Request', {:controller => 'friendships', 
        :action => 'create', 
        :user_id => current_user.id, 
        :friend_id => user.id,
        }, :method => :post)
      return @status.html_safe
    end
  end

  def friend_status_show(user)
    friend = Friendship.find_by(friend_id: current_user.id)
    @content = tag(:div)
    if friend
      @content << content_tag(:p, "#{friend.user.name} requested to be your friend")
    end
    if friend and friend.status == 'pending'
      @content << button_to('Accept', {:controller => 'friendships', 
        :action => 'update', 
        :id => friend.id,   
        :status => 'confirmed'
        }, :method => :put)

       @content << button_to('Reject', {:controller => 'friendships', 
        :action => 'update', 
        :id => friend.id,   
        :status => 'denied'
        }, :method => :put)
    elsif friend and (friend.status == 'denied' or friend.status == 'confirmed')
      @content << content_tag(:p, friend.status)
    else  
      friend = Friendship.find_by(friend_id: @user.id, user_id: current_user.id)
      if friend
        @content << content_tag(:p, friend.status)
      end
    end
    @content.html_safe
  end


end

