# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create({email: "test@mail.com", password: "password", password_confirmation: "password", name: "Test user",
username: "test12"})
User.create({email: "jankowal@mail.com", password: "password", password_confirmation: "password", name: "Jan Kowalski",
username: "kowal2115"})

5.times do |x|
  post = Post.create({caption: "My #{x} post", user: x.even? ? User.first : User.last})
  post.photos.attach(
    io:           File.open(Rails.root.join("app", "assets", "images", "dev_only_placeholder_post_#{(x % 2) + 1}.jpg")),
    filename:     "dev_only_placeholder_post_#{(x % 2) + 1}.jpg",
    content_type: "image/jpg"
  )
end
