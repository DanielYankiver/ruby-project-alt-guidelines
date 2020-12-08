

class User < ActiveRecord::Base
    has_many :orders

    def past_orders
        orders.where(checked_out: true)
    end

    def current_cart
        if orders.find_by(checked_out: false)
            orders.find_by(checked_out: false)
        else 
            t = Time.now
            orders.create(checked_out: false, order_time: t)
        end 

    end

    def check_out_current_cart 
        system 'clear'
        puts "Your order has been submitted!" 
        puts ""
        puts "The following ice creams will be ready shortly:"
        puts ""
        puts self.display_cart 
        puts ""
        puts "Total: $#{current_cart.total_price}"
        puts ""
        self.current_cart.update(checked_out: true)
        puts "Thank you for SCOOPING with us!"
        sleep 10
        exit_app
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
        puts " "
        puts "You're one scoop away from picking your ice cream!"
        puts " "
        puts "What\'s your username?"
        username = gets.chomp
        puts "What\'s your password?"
        password = gets.chomp

        user = User.find_by(username: username, password: password)

        if user.nil?
            puts " "
            puts "Sorry, nobody with that username and password exists!"
            sleep 3
            system 'clear'
            login_a_user
        else
            user
        end
    end

    def self.register_a_user
        puts " "
        puts "You're one scoop away from picking your ice cream!"
        puts " "
        puts "What do you want your username to be?"
        username = gets.chomp
        puts "What do you want your password to be?"
        password = gets.chomp

        user = User.find_by(username: username)

        if user
            puts "Sorry, that username is already taken, scoop again..."
        else
            User.create(username: username, password: password)
        end
    end


    
end