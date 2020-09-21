require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'positive validation test' do
    it 'ensures presence of user id, post id, and content' do
      User.new(name: 'Last', email: 'sample@gmail.com', password: 'testing', id: 1).save
      Post.new(content: 'First Post', user_id: 1, id: 1).save
      comment = Comment.new(user_id: 1, post_id: 1, content: 'First Comment').save
      expect(comment).to eq(true)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of user id, post id, and content' do
      User.new(name: 'Last', email: 'sample@gmail.com', password: 'testing', id: 1).save
      Post.new(content: 'First Post', user_id: 1, id: 1).save
      comment = Comment.new(user_id: 1, post_id: 1).save
      expect(comment).to eq(false)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of user id, post id, and content' do
      User.new(name: 'Last', email: 'sample@gmail.com', password: 'testing', id: 1).save
      Post.new(content: 'First Post', user_id: 1, id: 1).save
      comment = Comment.new(user_id: 1, content: 'First Comment').save
      expect(comment).to eq(false)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of user id, post id, and content' do
      User.new(name: 'Last', email: 'sample@gmail.com', password: 'testing', id: 1).save
      Post.new(content: 'First Post', user_id: 1, id: 1).save
      comment = Comment.new(post_id: 1, content: 'First Comment').save
      expect(comment).to eq(false)
    end
  end
end
