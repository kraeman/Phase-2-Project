class Cake < ActiveRecord::Base
    belongs_to :receiver, class_name: 'User'
    belongs_to :giver, class_name: 'User'
    has_many :ingredients, through: :cake_ingredient
end