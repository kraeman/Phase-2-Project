class Cake < ActiveRecord::Base
    belongs_to :user
    validates :name, :recipe, :cook_time, presence: true
end