class User < ActiveRecord::Base
    has_many :received_cakes, class_name: "Cake", foreign_key: "receiver_id"
    has_many :given_cakes, class_name: "Cake", foreign_key: "giver_id"
    has_many :received_gifts, class_name: "Gift", foreign_key: "receiver_id"
    has_many :given_gifts, class_name: "Gift", foreign_key: "giver_id"
    has_many :ingredients, through: :cake
end