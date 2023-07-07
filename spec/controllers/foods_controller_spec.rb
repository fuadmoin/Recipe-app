require 'rails_helper'

RSpec.describe FoodsController, type: :controller do
  describe 'GET #index' do
    context 'when user is authenticated' do
      it 'assigns the user foods to @foods' do
        user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
        food1 = user.foods.create(name: 'Food 1', measurement_unit: 'unit', price: 10, quantity: 5)
        food2 = user.foods.create(name: 'Food 2', measurement_unit: 'unit', price: 15, quantity: 3)
        sign_in user

        get :index
        expect(assigns(:foods)).to eq([food1, food2])
      end

      it 'renders the index template' do
        user = User.create(name: 'Test User', email: 'test@example.com', password: 'password')
        sign_in user

        get :index
        expect(response).to render_template(:index)
      end
    end

    it 'when user is not authenticated redirects to sign-in page' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
      let(:valid_params) { { food: { name: 'Food', measurement_unit: 'unit', price: 10, quantity: 5 } } }

      before { sign_in user }

      it 'creates a new food' do
        expect {
          post :create, params: valid_params
        }.to change(Food, :count).by(1)
      end

      it 'redirects to the created food' do
        post :create, params: valid_params
        expect(response).to redirect_to(Food.last)
      end

      it 'renders the new template if food is not saved' do
        allow_any_instance_of(Food).to receive(:save).and_return(false)

        post :create, params: valid_params
        expect(response).to render_template(:new)
      end
    end

    it 'when user is not authenticated redirects to sign-in page' do
      post :create, params: { food: { name: 'Food', measurement_unit: 'unit', price: 10, quantity: 5 } }
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { User.create(name: 'Test User', email: 'test@example.com', password: 'password') }
    let!(:food) { user.foods.create(name: 'Food', measurement_unit: 'unit', price: 10, quantity: 5) }

    before { sign_in user }

    it 'destroys the food' do
      expect {
        delete :destroy, params: { id: food.id }
      }.to change(Food, :count).by(-1)
    end

    it 'redirects to the foods index page' do
      delete :destroy, params: { id: food.id }
      expect(response).to redirect_to(foods_path)
    end
  end
end
