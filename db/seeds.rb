# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
8.times do |n|
  product = Product.create(
    name: "商品 #{n + 1}",
    description: "これは商品 #{n + 1}の説明文です。",
    price: (n + 1) * 1000
  )

  image_path = Rails.root.join('app/assets/images/test.jpg')
  product.image.attach(io: File.open(image_path), filename: 'test.jpg')
end
