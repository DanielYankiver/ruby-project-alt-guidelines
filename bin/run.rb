require_relative '../config/environment'

# puts "hello world"

cli = Application.new
cli.greet

user_or_nil = cli.login_register

until user_or_nil
    # system "clear"
    user_or_nil = cli.login_register
end

# If/ when it exits the until loop, `user_or_nil` is a user_obj
cli.user = user_or_nil
cli.main_menu