class Order < ActiveRecord::Base
    belongs_to :user

    has_many :icecreamorders
    has_many :icecreams, through: :icecreamorders



    def total_price
        self.icecreams.sum(:price)
    end

    # def total_price
    #     # self.books.map do |book|
    #     #     book.price
    #     # end.sum
    #     self.books.sum(:price)
    # end

end