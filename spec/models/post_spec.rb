require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'positive validation test' do
    it 'ensures presence of user id and content' do
      User.new(name: 'Last', email: 'sample@gmail.com', password: 'testing', id: 1).save
      post = Post.new(content: 'First Post', user_id: 1).save
      expect(post).to eq(true)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of user id and content' do
      User.new(name: 'Last', email: 'sample@gmail.com', password: 'testing', id: 1).save
      post = Post.new(content: 'First Post').save
      expect(post).to eq(false)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of user id and content' do
      User.new(name: 'Last', email: 'sample@gmail.com', password: 'testing', id: 1).save
      post = Post.new(user_id: 1).save
      expect(post).to eq(false)
    end
  end
end
