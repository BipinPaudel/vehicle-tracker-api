5.times do
  Category.create({
    title: Faker::Book.title,
    description: Faker::Book.genre
  })
end
