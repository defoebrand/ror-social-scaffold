require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { User.create(name: 'testuser', email: 'test@test.com', password: 'passwordpass', password_confirmation: 'passwordpass') }

  describe 'it should redirect to login/signup path if user is not signed in' do
    subject { get :index }
    it { should redirect_to(new_user_session_path) }
  end

  describe 'when a user is logged in' do
    it 'returns a successful response after signing in' do
      sign_in user
      get :index
      assert_response :success
    end
  end

  describe 'posts#create' do
    it 'should not create a new post when field is empty' do
      sign_in user
      visit '/posts'

      expect { click_button "Save" }.to change(Post, :count).by(0)
    end
  end
end