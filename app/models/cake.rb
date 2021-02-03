class Cake < ActiveRecord::Base
    belongs_to :person
    has_many :ingredients, through: :cake_ingredient
end