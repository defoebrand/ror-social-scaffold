require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'positive validation test' do
    it 'ensures presence of user id and post id' do
      User.new(name: 'First', email: 'sample1@gmail.com', password: 'testing', id: 1).save
      Post.new(content: 'First Post', user_id: 1, id: 1).save
      like = Like.new(user_id: 1, post_id: 1).save
      expect(like).to eq(true)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of user id and post id' do
      User.new(name: 'First', email: 'sample1@gmail.com', password: 'testing', id: 1).save
      Post.new(content: 'First Post', user_id: 1, id: 1).save
      like = Like.new(user_id: 1).save
      expect(like).to eq(false)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of user id and post id' do
      User.new(name: 'First', email: 'sample1@gmail.com', password: 'testing', id: 1).save
      Post.new(content: 'First Post', user_id: 1, id: 1).save
      like = Like.new(post_id: 1).save
      expect(like).to eq(false)
    end
  end
end
