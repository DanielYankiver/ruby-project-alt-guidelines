class Order < ActiveRecord::Base
    belongs_to :user

    has_many :icecreamorders
    has_many :icecreams, through: :icecreamorders

end