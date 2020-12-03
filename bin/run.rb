require_relative '../config/environment'

puts "hello world"
puts User.first
will = User.first
puts will.past_orders
will.display_cart
