class Ingredient < ActiveRecord::Base
    has_many :cakes, through: :cake_ingredient
end