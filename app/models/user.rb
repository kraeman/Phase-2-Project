class User < ActiveRecord::Base
    has_many :received_cakes, class_name: "Cake", foreign_key: "receiver_id"
    has_many :given_cakes, class_name: "Cake", foreign_key: "giver_id"
end