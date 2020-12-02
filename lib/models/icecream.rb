class Icecream < ActiveRecord::Base
    has_many :icecreamorders
    has_many :orders, through: :icecreamorders 
end