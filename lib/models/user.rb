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
        puts "Here is all of the icecream you have in your cart:"
        self.display_cart
        puts "Let's checkout!"
        self.current_cart.update(checked_out: true)
    end 


    def display_cart 
        self.current_cart.icecreamorders.map do |icecreamorder|
            icecreamorder.icecream.flavor
        end 
    end 

    def add_icecream_to_cart(icecream)
        Icecreamorder.create(order: self.current_cart, icecream: icecream)
    end 

    def remove_icecream_from_cart(icecreamorder_id)
        Icecreamorder.destroy(icecreamorder_id)
    end

    

    def self.login_a_user
        puts "You're one scoop away from picking your ice cream!"
        puts "What\'s your username?"
        username = gets.chomp
        puts "What\'s your password?"
        password = gets.chomp

        user = User.find_by(username: username, password: password)

        if user.nil?
            puts "Sorry, nobody with that username and password exists!"
        else
            user
        end
    end

    def self.register_a_user
        puts "What is your username?"
        username = gets.chomp
        puts "What is your password?"
        password = gets.chomp

        user = User.find_by(username: username)

        if user
            puts "Sorry, that username is already taken, scoop again..."
        else
            User.create(username: username, password: password)
        end
    end


    
end