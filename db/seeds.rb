
puts "🛠️ Resetting database and seeding new data..."

# Reset the database
Customer.destroy_all
Item.destroy_all
Shop.destroy_all
Discount.destroy_all
ComboDiscount.destroy_all

# Create 20 customers with Faker
20.times do
  Customer.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number
  )
end

puts "✅ 20 Customers created successfully!"

# Array of random coffee-related items with descriptions
coffee_items = [
  { name: "Espresso", description: "A strong and rich shot of pure coffee." },
  { name: "Cappuccino", description: "Espresso with steamed milk and frothy foam." },
  { name: "Latte", description: "A smooth blend of espresso and steamed milk." },
  { name: "Americano", description: "Espresso diluted with hot water for a milder taste." },
  { name: "Mocha", description: "Espresso with chocolate and steamed milk." },
  { name: "Flat White", description: "A velvety coffee with microfoam milk." },
  { name: "Macchiato", description: "Espresso with a small amount of frothy milk." },
  { name: "Cortado", description: "Equal parts espresso and warm milk." },
  { name: "Affogato", description: "Espresso poured over a scoop of vanilla ice cream." },
  { name: "Cold Brew", description: "Smooth, less acidic coffee brewed cold for hours." }
]

coffee_items.each do |item|
  Item.create!(
    name: item[:name],
    description: item[:description],
    price: rand(2.5..20.0).round(2),
    quantity: rand(5..50)
  )
end

puts "✅ 10 Coffee items created successfully!"

# Create 10 shops
shops = [
  { name: "Starbucks Downtown", region: "California", tax_rate: 7.25 },
  { name: "Starbucks Mall", region: "California", tax_rate: 7.25 },
  { name: "Starbucks Central", region: "California", tax_rate: 7.25 },
  { name: "Starbucks Seattle", region: "Washington", tax_rate: 6.50 },
  { name: "Starbucks Redmond", region: "Washington", tax_rate: 6.70 },
  { name: "Starbucks New York", region: "New York", tax_rate: 8.25 },
  { name: "Starbucks Brooklyn", region: "New York", tax_rate: 8.50 },
  { name: "Starbucks Miami", region: "Florida", tax_rate: 6.00 },
  { name: "Starbucks Orlando", region: "Florida", tax_rate: 6.50 },
  { name: "Starbucks Tampa", region: "Florida", tax_rate: 6.25 }
]

shops.each { |shop| Shop.create!(shop) }
puts "✅ 10 Shops created successfully!"

# Create Discounts
10.times do |i|
  discount_type = i.even? ? "percentage" : "combo"
  Discount.create!(
    name: "Discount ##{i + 1}",
    discount_type: discount_type,
    value: discount_type == "percentage" ? rand(5.0..25.0).round(2) : nil,
    condition: discount_type == "combo" ? "Buy 2, get 1 free" : nil
  )
end

puts "✅ 10 Discounts created successfully!"

# Create Combo Discounts
items = Item.all.sample(5) # Select 5 random items
Discount.combo.each_with_index do |discount, index|
  ComboDiscount.create!(
    discount: discount,
    item: items[index],
    free_items_count: rand(1..3)
  )
end

puts "✅ 5 Combo Discounts created successfully!"
puts "🎉 Database seeding completed!"
