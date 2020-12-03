class User < ActiveRecord::Base
    has_many :orders

    def past_orders
        orders.where(checked_out: true)
    end

    def current_cart
        # Look into order time and maybe add a conditional 
        orders.find_or_create_by(checked_out: false, order_time: Time.now)
    end

    # def check_out_current_cart 


    # end 


    # def display_cart 
    #     binding.pry
    #     self.current_cart.icecreamorders.each do |icecreamorder|
    #         puts "Order number: #{icecreamorder.id}. Flavor: #{icecreamorder.icecream.flavor}"
    #         binding.pry
    #     end 
    # end 

   

end