# This is not the place for test data
# Only use this to put the necessary setup for the app to work
# Separate the seeds in different Seed Service Objects
# The data can then be loaded with the rails db:seed command

require 'faker'

User.create(first_name: 'admin', last_name: 'test', email: 'admin@admin.com', password: 'password', password_confirmation: 'password',
            admin: true)

10.times do
  User.create(first_name: Faker::Name.unique.name, last_name: Faker::Name.unique.name, email: Faker::Internet.email, password: 'password',
              password_confirmation: 'password')
end

100.times do
  Item.create(title: Faker::Commerce.product_name, description: 'lorem ipsum', price: Faker::Commerce.price,
              tax_rate: rand(0..30))
end

Offer.create(item_id: 3, discount: 10)

Combo.create(item_id: 2, quantity: 2, active: true)

Offer.create(item_id: 4, discount: 5, combo_id: 1)
