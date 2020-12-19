5.times do
  Category.create({
    title: Faker::Book.title,
    description: Faker::Book.genre
  })
end

# creating vehicles
10.times do
  Vehicle.create({
    description: Faker::Vehicle.make,
    price: Faker::Number.between(1000, 2000),
    buy_date: Date.today.year - Faker::Number.between(1,20),
    make_year: Date.today.year - Faker::Number.between(20, 30),
    category_id: Faker::Number.between(1, 3),
    user_id: Faker::Number.between(1, 3)
  })
end
