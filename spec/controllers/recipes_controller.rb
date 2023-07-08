require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  describe 'GET #index' do
    it 'requires authentication' do
      get :index
      expect(response).to redirect_to(new_user_session_path)
    end

    context 'when user is authenticated' do
      let(:user) do
        User.create(name: 'Test User', email: 'test@example.com', password: 'password', confirmed_at: Time.now)
      end

      before { sign_in user }

      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'assigns all recipes to @recipes' do
        recipe1 = Recipe.create!(name: 'Recipe 1', user:, preparation_time: 30, cooking_time: 45)
        recipe2 = Recipe.create!(name: 'Recipe 2', user:, preparation_time: 20, cooking_time: 60)

        get :index
        expect(assigns(:recipes)).to eq([recipe1, recipe2])
      end
    end
  end

  describe 'GET #show' do
    context 'when user is authenticated' do
      let(:user) do
        User.create(name: 'Test User', email: 'test@example.com', password: 'password', confirmed_at: Time.now)
      end
      let(:recipe) { Recipe.create!(name: 'Recipe 2', user:, preparation_time: 20, cooking_time: 60) }

      before { sign_in user }

      it 'renders the show template' do
        get :show, params: { id: recipe.id }
        expect(response).to render_template(:show)
      end

      it 'assigns the requested recipe to @recipe' do
        get :show, params: { id: recipe.id }
        expect(assigns(:recipe)).to eq(recipe)
      end

      it 'assigns the user foods to @foods' do
        food1 = user.foods.create(name: 'Food 1', price: 10, quantity: 5)
        food2 = user.foods.create(name: 'Food 2', price: 10, quantity: 5)
        recipe.food_recipes.create(food: food1, quantity: 3)

        get :show, params: { id: recipe.id }
        expect(assigns(:foods)).to eq([food2])
      end
    end
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      let(:user) do
        User.create(name: 'Test User', email: 'test@example.com', password: 'password', confirmed_at: Time.now)
      end
      let(:valid_params) { { recipe: { name: 'Recipe', preparation_time: 20, cooking_time: 60, user_id: user.id } } }

      before { sign_in user }

      it 'creates a new recipe' do
        expect do
          post :create, params: valid_params
        end.to change(Recipe, :count).by(1)
      end

      it 'redirects to the created recipe' do
        post :create, params: valid_params
        expect(response).to redirect_to(Recipe.last)
      end
    end
  end

  describe 'PATCH #update_public_status' do
    context 'when user is authenticated' do
      let(:user) do
        User.create(name: 'Test User', email: 'test@example.com', password: 'password', confirmed_at: Time.now)
      end
      let(:recipe) { Recipe.create(name: 'Recipe', preparation_time: 20, cooking_time: 60, user:, public: false) }

      before { sign_in user }

      it 'updates the public status of the recipe' do
        expect do
          patch :update_public_status, params: { id: recipe.id }
        end.to change { recipe.reload.public }.from(false).to(true)
      end

      it 'redirects to the updated recipe' do
        patch :update_public_status, params: { id: recipe.id }
        expect(response).to redirect_to(recipe)
      end
    end
  end

  describe 'GET #public_recipes' do
    let(:user) do
      User.create(name: 'Test User', email: 'test@example.com', password: 'password', confirmed_at: Time.now)
    end

    before { sign_in user }

    it 'renders the public_recipes template' do
      get :public_recipes
      expect(response).to render_template(:public_recipes)
    end

    it 'assigns public recipes to @recipes' do
      recipe1 = Recipe.create(name: 'Recipe 1', user_id: user.id, preparation_time: 20, cooking_time: 60, public: true)
      recipe2 = Recipe.create(name: 'Recipe 2', user_id: user.id, preparation_time: 20, cooking_time: 60, public: true)
      Recipe.create(name: 'Recipe 3', user_id: user.id, preparation_time: 20, cooking_time: 60, public: false)

      get :public_recipes
      expect(assigns(:recipes)).to eq([recipe1, recipe2])
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is authenticated' do
      let(:user) do
        User.create(name: 'Test User', email: 'test@example.com', password: 'password', confirmed_at: Time.now)
      end
      let(:recipe) { Recipe.create!(name: 'Recipe 2', user:, preparation_time: 20, cooking_time: 60) }

      before { sign_in user }

      it 'redirects to the recipes index page' do
        delete :destroy, params: { id: recipe.id }
        expect(response).to redirect_to(recipes_path)
      end
    end
  end
end
