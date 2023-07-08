class Recipe < ApplicationRecord
    belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  
    validates :name, presence: true
    validates :preparation_time, numericality: { greater_than_or_equal_to: 0 }
    validates :cooking_time, numericality: { greater_than_or_equal_to: 0 }
  end