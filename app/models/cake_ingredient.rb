class CakeIngredient < ActiveRecord::Base
    belongs_to :cake
    belongs_to :ingredient
  end
  