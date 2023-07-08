class Food < ApplicationRecord
    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
    has_many :recipes, through: :food_recipes

    validates :name, presence: true
    validates :price, numericality: {greater_than: 0}
    validates :quantity, numericality: {greater_than: 0}
end