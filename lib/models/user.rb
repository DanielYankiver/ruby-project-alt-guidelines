class User < ActiveRecord::Base
    has_many :orders

    def past_orders
        orders.where(checked_out: true)
    end

    def current_cart
        # Look into order time and maybe add a conditional 
        #orders.find_or_create_by(checked_out: false, order_time: Time.now)
        if orders.find_by(checked_out: false)
            orders.find_by(checked_out: false)
        else 
            orders.create(checked_out: false, order_time: Time.now)
        end 

    end

    def check_out_current_cart 
        puts "Welcome, #{self.username}!"
        puts "Here is all of the icecream you have in your cart:"
        self.display_cart
        puts "Let's checkout!"
        self.current_cart.update(checked_out: true)
    end 


    def display_cart 
        self.current_cart.icecreamorders.each do |icecreamorder|
            puts "#{icecreamorder.icecream.flavor}"
        end 
    end 

    def add_icecream_to_cart(icecream)
        Icecreamorder.create(order: self.current_cart, icecream: icecream)
    end 

    def remove_icecream_from_cart(icecreamorder_id)
        Icecreamorder.destroy(icecreamorder_id)
    end



   

end