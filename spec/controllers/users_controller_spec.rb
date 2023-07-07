require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do

    it 'when user is not authenticated redirects to sign-in page' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end

