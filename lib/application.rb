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
        # sleep 5
        # Wait 5 seconds and then execute
        prompt.select("Welcome, #{user.username}! What do you want to do?") do |menu|
            menu.choice "See my past orders", -> {past_orders}
            menu.choice "Add ice cream to cart", -> {see_all_pets}
            menu.choice "Smell you later", -> {smell_you_later}
            # menu.choice "WHAT USER SEES", -> {HELPER_METHOD }
        end
    end

    


end 