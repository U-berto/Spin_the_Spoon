
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

UserParty.destroy_all
Friendship.destroy_all
Party.destroy_all
Restaurant.destroy_all
User.destroy_all

user1 = User.create!(email: "alice@example.com", password: "password", username: "alice", address: "Carrer de Mallorca 12, Barcelona", public: true)
user2 = User.create!(email: "bob@example.com", password: "password", username: "bob", address: "Passeig de Gràcia 45, Barcelona", public: true)
user3 = User.create!(email: "carla@example.com", password: "password", username: "carla", address: "Carrer d'Aragó 77, Barcelona", public: true)
user4 = User.create!(email: "david@example.com", password: "password", username: "david", address: "Avinguda Diagonal 103, Barcelona", public: false)
user5 = User.create!(email: "elena@example.com", password: "password", username: "elena", address: "Carrer de Sants 66, Barcelona")

user1.friend(user2)
user1.friend(user3)
user2.friend(user4)
user3.friend(user5)
user4.friend(user5)

restaurant1 = Restaurant.create!(name: "Trattoria Da Gino", category: "Italian", location: "Via Roma 1, Barcelona", rating: 4)
restaurant2 = Restaurant.create!(name: "Sushi Yama", category: "Sushi", location: "Carrer de Sants 45, Barcelona", rating: 5)
restaurant3 = Restaurant.create!(name: "Osteria del Mare", category: "Seafood", location: "Passeig de Gràcia 10, Barcelona", rating: 4)
restaurant4 = Restaurant.create!(name: "Pizzeria Bella Napoli", category: "Pizza", location: "Rambla del Poblenou 33, Barcelona", rating: 5)
restaurant5 = Restaurant.create!(name: "La Griglia", category: "Steakhouse", location: "Carrer de Balmes 99, Barcelona", rating: 4)
restaurant6 = Restaurant.create!(name: "Ristorante Bella Vita", category: "Italian", location: "Gran Via 123, Barcelona", rating: 3)
restaurant7 = Restaurant.create!(name: "Tandoori Palace", category: "Indian", location: "Carrer de la Marina 50, Barcelona", rating: 5)
restaurant8 = Restaurant.create!(name: "Le Petit Bistro", category: "French", location: "Carrer de París 17, Barcelona", rating: 4)
restaurant9 = Restaurant.create!(name: "Wok Express", category: "Asian", location: "Avinguda Diagonal 201, Barcelona", rating: 3)
restaurant10 = Restaurant.create!(name: "Burger Lab", category: "American", location: "Carrer de Casanova 78, Barcelona", rating: 4)

restaurant11 = Restaurant.create!(name: "Zen Garden", category: "Sushi", location: "Carrer de Mallorca 10, Barcelona", rating: 5)
restaurant12 = Restaurant.create!(name: "Casa Toscana", category: "Italian", location: "Carrer de Muntaner 200, Barcelona", rating: 3)
restaurant13 = Restaurant.create!(name: "Tapas y Vino", category: "Spanish", location: "Carrer de Blai 2, Barcelona", rating: 4)
restaurant14 = Restaurant.create!(name: "Bavarian Hof", category: "German", location: "Carrer del Consell de Cent 121, Barcelona", rating: 4)
restaurant15 = Restaurant.create!(name: "La Brace", category: "Barbecue", location: "Carrer de Provença 74, Barcelona", rating: 5)
restaurant16 = Restaurant.create!(name: "Green Vegan", category: "Vegan", location: "Carrer de Laforja 56, Barcelona", rating: 3)
restaurant17 = Restaurant.create!(name: "Dolce Vita Café", category: "Cafe", location: "Carrer d'Enric Granados 130, Barcelona", rating: 4)
restaurant18 = Restaurant.create!(name: "Pho Street", category: "Vietnamese", location: "Carrer de Pau Claris 190, Barcelona", rating: 4)
restaurant19 = Restaurant.create!(name: "El Mariachi", category: "Mexican", location: "Carrer del Bruc 32, Barcelona", rating: 5)
restaurant20 = Restaurant.create!(name: "Curry House", category: "Indian", location: "Carrer d'Aragó 88, Barcelona", rating: 4)

restaurant21 = Restaurant.create!(name: "Brasserie Lyon", category: "French", location: "Carrer de Valencia 202, Barcelona", rating: 3)
restaurant22 = Restaurant.create!(name: "Dragon Palace", category: "Chinese", location: "Carrer de Villarroel 111, Barcelona", rating: 4)
restaurant23 = Restaurant.create!(name: "Spicy Bombay", category: "Indian", location: "Carrer de Tamarit 98, Barcelona", rating: 5)
restaurant24 = Restaurant.create!(name: "Soul Kitchen", category: "Soul Food", location: "Carrer d'Aribau 66, Barcelona", rating: 4)
restaurant25 = Restaurant.create!(name: "Casa Mexicana", category: "Mexican", location: "Carrer de Nàpols 143, Barcelona", rating: 4)
restaurant26 = Restaurant.create!(name: "Panino Giusto", category: "Fast Food", location: "Carrer de Sepúlveda 210, Barcelona", rating: 3)
restaurant27 = Restaurant.create!(name: "Kebab House", category: "Middle Eastern", location: "Carrer de Londres 58, Barcelona", rating: 4)
restaurant28 = Restaurant.create!(name: "Trattoria Sorriso", category: "Italian", location: "Carrer de Girona 41, Barcelona", rating: 5)
restaurant29 = Restaurant.create!(name: "BBQ Central", category: "Barbecue", location: "Carrer del Comte Borrell 99, Barcelona", rating: 4)
restaurant30 = Restaurant.create!(name: "Sapore di Mare", category: "Seafood", location: "Carrer de Pujades 88, Barcelona", rating: 5)


party1 = Party.create!(user: user1, restaurant: restaurant1, risk_level: "low")
party2 = Party.create!(user: user2, restaurant: restaurant2, risk_level: "medium")
party3 = Party.create!(user: user3, restaurant: restaurant3, risk_level: "high")


UserParty.create!(user: user2, party: party1, accepted: true)
UserParty.create!(user: user2, party: party2, accepted: true)
UserParty.create!(user: user3, party: party3, accepted: true)

# UserParty.create!(user: 4, party: 2, accepted: true)
# UserParty.create!(user: 5, party: 3, accepted: true)
# UserParty.create!(user: 1, party: 3, accepted: true)
