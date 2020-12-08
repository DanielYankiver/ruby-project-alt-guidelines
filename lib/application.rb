class Application

    attr_reader :prompt
    attr_accessor :user

    def initialize
        @prompt = TTY::Prompt.new
    end

    def greet
        clear_welcome_ascii
        sleep 5
        puts "Loading the scoops shop🍦🍦🍦"
        sleep 1
        clear_welcome_ascii
        puts "Loading the scoops shop🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦"
        sleep 1
        clear_welcome_ascii
        puts "Loading the scoops shop🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦"
        sleep 1
        clear_welcome_ascii
        puts "Loading the scoops shop🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦🍦 %100"
        sleep 1
    end

    def clear_welcome_ascii 
        system 'clear'
        puts 'Welcome to What\'s the Scoop, where all of your ice dreams come true!'
        puts render_ascii_art
    end

    def login_register
        system 'clear'
        print TTY::Box.frame "          WHAT'S THE SCOOP?         "
        puts ""
        prompt.select("Would you like to login or register?") do |menu|
            menu.choice "Login", -> {login_helper}
            menu.choice "Register", -> {register_helper}
            menu.choice "Exit", -> {exit_app_with_items_in_cart}
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
        system 'clear'
        prompt.select("What do you want to do, #{user.username}?") do |menu|
            menu.choice "View All Flavors and Pick a Scoop", -> {pick_flavor}
            menu.choice "See My Past Orders", -> {see_my_past_orders}
            menu.choice "Show Current Cart", -> {show_current_cart}
            menu.choice "Exit App", -> {exit_app}
        end
    end

    def pick_flavor
        system 'clear'
        print TTY::Box.frame "          SCOOPS MENU         "
        prompt.multi_select("What flavor do you want to add to your cart?") do |menu|
            Icecream.all.map do |icecream|
                menu.choice "#{icecream.flavor}: $#{icecream.price}", -> {user.add_icecream_to_cart(icecream)}
            end 
        end
        puts "You've added ice cream to your cart!"
        sleep 3
        show_current_cart 
    end
    

    def see_my_past_orders
        # need to add option for new user 
        system 'clear'
        puts "Past Orders:"
        puts " "
        user.past_orders.each do |order|
            order.icecreams.each do |icecream|
                puts "#{icecream.flavor} on #{order.order_time.strftime("%d/%m/%Y")} at #{order.order_time.strftime("%I:%M %p")}"
            end 
        end
        sleep 2
        puts " "
        prompt.select("What do you want to do next #{user.username}?") do |menu|
            menu.choice "View All Flavors and Pick a Scoop", -> {pick_flavor}
            menu.choice "Show Current Cart", -> {show_current_cart}
            menu.choice "Exit App", -> {exit_app}
        end
    end 

    def show_current_cart 
        system 'clear'
        user.current_cart
        if !user.display_cart.any?
            puts "There is nothing in your cart, #{user.username} :("
            puts "Please pick a flavor"
            sleep 3
            pick_flavor
        else 
            puts "These are the ice creams in your cart:" 
            puts ""
            user.display_cart.map {|item| puts "#{item}"}
            puts ""
            prompt.select("What would you like to do next, #{user.username}?") do |menu|
                menu.choice "Pick Another Scoop", -> {pick_flavor}
                menu.choice "Checkout", -> {checkout}
                menu.choice "Remove an Item", -> {remove_flavor_from_cart}
                menu.choice "Main Menu", -> {main_menu}
                menu.choice "Exit App", -> {exit_app}
            end
        end 
    end

    def checkout
        user.check_out_current_cart 
        puts render_ascii_art
        sleep 9
        exit_app
    end

    def remove_flavor_from_cart
        user.reload
        system 'clear'
        prompt.multi_select("What flavor would you like to remove, #{user.username}?") do |menu|
            user.current_cart.icecreamorders.each do |icecreamorder|
                menu.choice "#{icecreamorder.icecream.flavor}", -> {user.remove_icecream_from_cart(icecreamorder.id)}
            end
        end
        puts "Your cart has been updated!"
        sleep 2 
        if user.current_cart.icecreamorders.empty?
            main_menu
        else 
            show_current_cart 
        end 
    end 

    def exit_app 
        system 'clear'
        if user.current_cart.icecreamorders.empty?
            puts "🍦🍦🍦  SCOOP YOU LATER  🍦🍦🍦"
        else 
            prompt.select("You have items in you cart, #{user.username}. Are you sure you want to exit?") do |menu|
                menu.choice "Show Current Cart", -> {show_current_cart}
                menu.choice "Checkout", -> {checkout}
                menu.choice "Exit App", -> {exit_app_with_items_in_cart}
            end
        end 
        sleep 2
        exit
    end

    def exit_app_with_items_in_cart
        system 'clear'
        puts "🍦🍦🍦  SCOOP YOU LATER  🍦🍦🍦"
        sleep 2
        exit
    end 

    def render_ascii_art
        File.readlines("lib/Icecream.txt") do |line|
          puts line
        end
    end
    

end 