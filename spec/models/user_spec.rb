require 'rails_helper'

RSpec.describe User, type: :model do
  context 'positive validation test' do
    it 'ensures presence of name, email, and password' do
      user = User.new(name: 'Last', email: 'sample@gmail.com', password: 'testing').save
      expect(user).to eq(true)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of name, email, and password' do
      user = User.new(name: 'Last', email: 'sample@gmail.com').save
      expect(user).to eq(false)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of name, email, and password' do
      user = User.new(email: 'sample@gmail.com', password: 'testing').save
      expect(user).to eq(false)
    end
  end
  context 'negative validation test' do
    it 'ensures presence of name, email, and password' do
      user = User.new(name: 'Last', password: 'testing').save
      expect(user).to eq(false)
    end
  end
end
