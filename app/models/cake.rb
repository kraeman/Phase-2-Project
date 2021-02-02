class Cake < ActiveRecord::Base
    belongs_to :person
    has_many :ingredients
end