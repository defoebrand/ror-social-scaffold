require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::Test::ControllerHelpers

  describe 'it should redirect to login/signup path if user is not signed in' do
    subject { get :index }
    it { should redirect_to(new_user_session_path) }
  end

  describe 'when a user is logged in' do
    it 'returns a successful response after signing in' do
      user = User.create(name: 'testuser', email: 'test@test.com', password: 'passwordpass', password_confirmation: 'passwordpass')
      sign_in user
      get :index

      assert_response :success
    end
  end


end