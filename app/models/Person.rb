class Person < ActiveRecord::Base
    has_one :cake
    has_many :gifts
    has_many :invitations
    has_many :ingredients, through: :cake
end