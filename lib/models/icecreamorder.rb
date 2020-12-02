class Icecreamorder < ActiveRecord::Base
    belongs_to :order
    belongs_to :icecream
end