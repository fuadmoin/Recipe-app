// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener('DOMContentLoaded', function() {
    const foodForm = document.querySelector('#food-form');
    const addFoodButton = document.querySelector('#add-food-button');
  
    if (foodForm && addFoodButton) {
      addFoodButton.addEventListener('click', function() {
        if (foodForm.style.display === 'block') {
          foodForm.style.display = 'none';
          return;
        }
        foodForm.style.display = 'block';
      });
    }
  });
  