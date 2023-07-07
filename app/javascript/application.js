// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('turbo:load', function() {
    const foodForm = document.querySelector('#food-form');
    const addFoodButton = document.querySelector('#add-food-button');
    const ingredientsForm = document.querySelector('#ingredients');
    const addIngredientButton = document.querySelector('#ingredient');
  
    if (foodForm && addFoodButton) {
      addFoodButton.addEventListener('click', function() {
        if (foodForm.style.display === 'block') {
          foodForm.style.display = 'none';
          return;
        }
        foodForm.style.display = 'block';
      });
    }

    if (ingredientsForm && addIngredientButton) {
        addIngredientButton.addEventListener('click', function() {
            if (ingredientsForm.style.display === 'block') {
            ingredientsForm.style.display = 'none';
            return;
            }
            ingredientsForm.style.display = 'block';
        });
    }
  });
  