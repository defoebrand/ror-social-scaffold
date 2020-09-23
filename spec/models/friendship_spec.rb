require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'positive validation test' do
    it 'ensures presence of user id and friend id' do
      User.new(name: 'First', email: 'sample1@gmail.com', password: 'testing', id: 1).save
      User.new(name: 'Last', email: 'sample2@gmail.com', password: 'testing2', id: 2).save
      friend = Friendship.new(user_id: 1, friend_id: 2).save
      expect(friend).to eq(true)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of user id and friend id' do
      User.new(name: 'First', email: 'sample1@gmail.com', password: 'testing', id: 1).save
      User.new(name: 'Last', email: 'sample2@gmail.com', password: 'testing2', id: 2).save
      friend = Friendship.new(user_id: 1).save
      expect(friend).to eq(false)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of user id and friend id' do
      User.new(name: 'First', email: 'sample1@gmail.com', password: 'testing', id: 1).save
      User.new(name: 'Last', email: 'sample2@gmail.com', password: 'testing2', id: 2).save
      friend = Friendship.new(friend_id: 2).save
      expect(friend).to eq(false)
    end
  end
end
