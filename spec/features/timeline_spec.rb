require 'rails_helper'

RSpec.feature "Timeline", type: :feature do
  
  context 'Create new posts and comments' do
    before(:each) do      
      test_user   = User.create(name: 'user1',
                             email: 'user@user.com',
                             password: 'passwords',
                             password_confirmation: 'passwords')
     

      test_post   = Post.create(user_id: 1, content: 'another post')                         

      visit new_user_session_path

      within('form') do 
        fill_in 'Email', with: 'user@user.com'
        fill_in 'Password', with: 'passwords'
      end
      click_button 'Log in'
      
      visit root_path

      within('form.new_post') do 
        fill_in 'Content', with: 'A new post'
      end

      click_button 'Save'
    end
  

    it 'visits the root path after logging in' do
      visit root_path
      expect(page).to have_content('Recent posts')
    end

    it 'creates a new post' do
      visit root_path
      within('form.new_post') do 
        fill_in 'Content', with: 'A new post'
      end
      
      expect {click_button 'Save'}.to change(Post, :count).by(1)
    end


    it 'creates a new comment' do 
      visit root_path
      within('form.new_comment') do 
        fill_in 'comment_content', with: 'A new comment'
      end

      expect {click_button 'Comment'}.to change(Comment, :count).by(1)
    end

  end
end