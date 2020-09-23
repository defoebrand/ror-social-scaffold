module UsersHelper
  def friend_status_index(user)
    @status = tag(:div, class: 'status-btn-tag')
    button_changer(@status, user)
  end

  def friend_response_show(user)
    @content = tag(:div)
    button_changer(@content, user)
  end

  private

  def button_changer(content, user)
    if @friends.any? { |f| f.friend_id == user.id or f.user_id == user.id }
      button_selector(content, user)
    else
      request_button(content, user)
    end
    content
  end

  def button_selector(content, user)
    friend = Friendship.find_by(friend_id: current_user.id, user_id: user.id)
    if friend
      friend_requests(friend, content, user)
    else
      my_requests(content, user)
    end
  end

  def friend_requests(friend, content, user)
    if friend.status == 'pending'
      content << content_tag(:p, "#{friend.user.name} requested to be your friend")
      content << tag(:br)
      content << button_to('Accept', { controller: 'friendships',
                                       action: 'update',
                                       id: friend.id,
                                       friend_id: friend.friend_id,
                                       user_id: friend.user_id,
                                       status: 'confirmed' }, method: :put)

      content << button_to('Reject', { controller: 'friendships',
                                       action: 'update',
                                       id: friend.id,
                                       status: 'denied' }, method: :put)
    elsif friend.status == 'confirmed'
      content << content_tag(:p, "Request #{friend.status}", class: 'status')
    elsif friend.status == 'denied'
      friend.destroy
      request_button(content, user)
    end
  end

  def my_requests(content, user)
    friend = Friendship.find_by(friend_id: user.id, user_id: current_user.id)
    content << content_tag(:p, "Request #{friend.status}", class: 'status') if friend
  end

  def request_button(content, user)
    content << button_to('Request Friendship', { controller: 'friendships',
                                                 action: 'create',
                                                 user_id: current_user.id,
                                                 friend_id: user.id }, method: :post)
    content.html_safe
  end
end
