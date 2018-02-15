# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'rest-client'

rocket_url = 'https://launchlibrary.net/1.3/rocket'
rocket_response = RestClient.get(rocket_url)
rocket_data = JSON.parse(rocket_response)

rocket_family_url = 'https://launchlibrary.net/1.3/rocketfamily'
rocket_fam_response = RestClient.get(rocket_family_url)
rocket_family = JSON.parse(rocket_fam_response)


Rocket.delete_all

rocket_data.each do |rocket|
  Rocket.create(:id => rocket.id, :name => rocket.name, :info => rocket.infoUrl, :wiki => rocket.wikiUrl, :img => rocket.image )
end

Rocket.each do |rock|
  puts rock
end