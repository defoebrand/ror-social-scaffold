require 'rails_helper'

RSpec.feature 'Friendships', type: :feature do
  before(:each) do
    User.create(name: 'user1',
                email: 'user@user.com',
                password: 'passwords',
                password_confirmation: 'passwords',
                id: 1)
    User.create(name: 'friend',
                email: 'friend@user.com',
                password: 'passwords',
                password_confirmation: 'passwords',
                id: 2)

    visit new_user_session_path

    within('form') do
      fill_in 'Email', with: 'user@user.com'
      fill_in 'Password', with: 'passwords'
    end
    click_button 'Log in'
  end

  it 'creates a new friendship request' do
    visit users_path

    expect { click_button 'Request Friendship' }.to change(Friendship, :count).by(1)
  end

  it 'confirms friendship upon acceptance' do
    Friendship.create(user_id: 2, friend_id: 1, status: 'pending')
    visit users_path

    click_button 'Accept'
    expect(page).to have_content('Request confirmed')
  end

  it 'denies friendship upon acceptance' do
    Friendship.create(user_id: 2, friend_id: 1, status: 'pending')
    visit users_path

    click_button 'Reject'
    expect(page).to have_content('Request denied')
  end
end
