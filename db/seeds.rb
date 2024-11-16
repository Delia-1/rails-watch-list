# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# require 'faker'



puts 'Creating films'

# 10.times do
#    Movie.create!(
#     title: Faker::Movie.title,
#     overview: Faker::Lorem.sentence(word_count: 3, supplemental: true, random_words_to_add: 15),
#     poster_url: Faker::Avatar.image(size: "300x300", format: "png"),
#     rating: rand(0..10)
#     )
# end

require 'uri'
require 'net/http'

url = URI.parse("https://tmdb.lewagon.com/movie/top_rated")
response = Net::HTTP.get(url)
movies = JSON.parse(response)["results"].first(10)


movies.each do |movie|
  Movie.create!(
   title: movie["title"],
   overview: movie["overview"],
   poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
   rating: movie["vote_average"]
   )
end
puts "created #{Movie.count} movies"
