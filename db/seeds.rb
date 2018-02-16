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

agency_url = 'https://launchlibrary.net/1.3/agency'
agency_response = RestClient.get(agency_url)
agency_data = JSON.parse(agency_response)

Rocket.delete_all
Agency.delete_all
# agency_data['agencies'].each do |agency|
#    @agency_id = agency["id"]
#    @name = agency["name"]
#    @abbrev = agency["abbrev"]
#    @countryCode = agency["countryCode"]
#    @islsp = agency["islsp"]
#    Agency.create(agency_id:@agency_id, name:@name,abbrev:@abbrev,countryCode:@countryCode,islsp:@islsp).save
# end


rocket_data['rockets'].each do |rocket|
  @rocket_name = rocket["name"]
  @rocket_info = rocket["infoURL"]
  @rocket_wiki = rocket["wikiURL"]
  @rocket_img = rocket["imageURL"]
  rocket_family_url = "https://launchlibrary.net/1.3/rocketfamily/#{@rocket_name.split(' ')[0]}"
  rocket_fam_response = RestClient.get(rocket_family_url)
  rocket_family = JSON.parse(rocket_fam_response)["RocketFamilies"][0]
  unless rocket_family.nil?
    @agency =  rocket_family["agencies"]

  end

#   @agency_id = @rocket_family["id"]
#   @name = @rocket_family["name"]
#   @abbrev = @rocket_family["abbrev"]
#   @countryCode = @rocket_family["countryCode"]
#   Agency.create(agency_id:@agency_id, name:@name,abbrev:@abbrev,countryCode:@countryCode,islsp:@islsp).save
#
# puts Agency.count
     #a.rocket.create(name: @rocket_name, info:@rocket_info, wiki:@rocket_wiki, img:@rocket_img, agency:a.agency_id).save
  end


