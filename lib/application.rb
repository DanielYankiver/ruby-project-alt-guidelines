class Application

    attr_reader :prompt
    attr_accessor :user

    def initialize
        @prompt = TTY::Prompt.new
    end

    def greet
        puts 'Welcome to What\'s the Scoop, where all of your ice dreams come true!'
    end

    def login_register
        prompt.select("Would you like to register or login?") do |menu|
            menu.choice "Register", -> {register_helper}
            menu.choice "Login", -> {login_helper}
            menu.choice "Exit"
        end
    end

    def login_helper
        User.login_a_user
    end

    def register_helper
        User.register_a_user
    end

    def main_menu
        user.reload
        # Gets the most up to date info about the user
        system 'clear'
        # "clears" the terminal
        prompt.select("Welcome, #{user.username}! What do you want to do?") do |menu|
            menu.choice "View all flavors and Pick a scoop", -> {pick_flavor}
            menu.choice "See my past orders", -> {see_my_past_orders}
            menu.choice "Show current cart", -> {show_current_cart}
            menu.choice "Exit App"
            # menu.choice "WHAT USER SEES", -> {HELPER_METHOD }
        end
    end

    def pick_flavor
        prompt.select("What flavor do you want to add to your cart?") do |menu|
            # menu.choice "Register", -> {register_helper}
            # menu.choice "Login", -> {login_helper}
            # menu.choice "Exit"
            Icecream.all.map do |icecream|
                menu.choice "#{icecream.flavor}", -> {user.add_icecream_to_cart(icecream)}
            end
            
        end
        puts "You've added #{user.display_cart.last} to your cart!"
        #puts "You've added #{user.display_cart.last.icecream.flavor} to your cart!"
        sleep 5
        main_menu
    end

    def see_my_past_orders
        # puts user.past_orders.icecreamorder.icecream.flavor
        user.past_orders.each do |order|
            order.icecreams.each do |icecream|
                puts "You scooped #{icecream.flavor} on #{order.order_time} :) "
            end 
        end
        sleep 7
        main_menu
    end 

    def show_current_cart 
        user.current_cart
        if !user.display_cart.any?
            puts "There is nothing in your cart #{user.username}!"
            puts "Please pick a flavor"
            sleep 3
            pick_flavor
        else 
            puts "Looks like you have items in your cart:" 
            puts user.display_cart
            prompt.select("What would you like to do next #{user.username}?") do |menu|
                menu.choice "Pick Another Scoop", -> {pick_flavor}
                menu.choice "Go to Checkout", -> {checkout_method}
                menu.choice "Remove an Item", -> {remove_method}
                menu.choice "Main Menu", -> {main_menu}
                menu.choice "Exit App"
            end
        end 

    end

end 