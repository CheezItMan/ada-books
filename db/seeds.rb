# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |x|
  name = Faker::Book.unique.title
  author = Author.new name: name
  unless author.save
    puts "Failed to save #{name}"
  end
end


authors = Author.all

20.times do |x|
  title = Faker::Book.unique.title
  description = Faker::Book.unique.genre
  price = rand(30)
  book = Book.new title: title, description: description, price: price, author: authors.sample
  unless book.save
    puts "Failed to save #{title}"
  end
end
