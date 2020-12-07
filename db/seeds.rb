# Write in the data that needs to be populated within our database
# puts "Hello, I'm creating..."

Icecream.destroy_all
Icecreamorder.destroy_all
User.destroy_all
Order.destroy_all

# ICECREAM #
chocolate = Icecream.create(flavor: "🍫 CHOCOLATE", price: 3)
cookies = Icecream.create(flavor: "🍪 COOKIES AND CREAM", price: 4)
coffee = Icecream.create(flavor: "🤎 COFFEE", price: 3)
vanilla = Icecream.create(flavor: "🍦 VANILLA", price: 2)
organic_strawberry = Icecream.create(flavor: "🍓 ORGANIC STRAWBERRY", price: 5)
mint = Icecream.create(flavor: "🌱 MINT CHOCOLATE CHIP", price: 4)
cherry_cheesecake = Icecream.create(flavor: "🍰 CHERRY CHEESECAKE", price: 5)
pistachio = Icecream.create(flavor: "💚 PISTACHIO", price: 4)
vegan_chocolate_chip = Icecream.create(flavor: "🍪 VEGAN CHOCOLATE CHIP", price: 7)
vegan_ = Icecream.create(flavor: "🍵 VEGAN COCONUT MATCHA", price: 7)

# USER # 
will = User.create(username: "will", password: "prince123")
carlton = User.create(username: "carlton", password: "fresh123")
ashley = User.create(username: "ashley", password: "ash123")
hilary = User.create(username: "hilary", password: "clothing123")
philip = User.create(username: "philip", password: "food123")
geoffrey = User.create(username: "geoffrey", password: "snarky123")

# ORDER #

past_order1 = Order.create(checked_out: true, user: will, order_time: Time.now)
past_order2 = Order.create(checked_out: true, user: carlton, order_time: Time.now)
past_order3 = Order.create(checked_out: true, user: ashley, order_time: Time.now)
past_order4 = Order.create(checked_out: true, user: will, order_time: Time.now)
current_order1 = Order.create(checked_out: false, user: will, order_time: Time.now)
current_order2 = Order.create(checked_out: false, user: carlton, order_time: Time.now)

# ICECREAM ORDER # 

Icecreamorder.create(order: past_order1, icecream: cookies)
Icecreamorder.create(order: past_order1, icecream: organic_strawberry)
Icecreamorder.create(order: past_order2, icecream: coffee)
Icecreamorder.create(order: past_order3, icecream: cookies)
Icecreamorder.create(order: past_order2, icecream: mint)
Icecreamorder.create(order: current_order1, icecream: vanilla)
Icecreamorder.create(order: current_order2, icecream: chocolate)
