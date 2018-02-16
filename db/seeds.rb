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

rocket_data['rockets'].each do |rocket|
  @rocket_name = rocket["name"]
  rocket_family_url = "https://launchlibrary.net/1.3/rocketfamily/#{@rocket_name.split(' ')[0]}"
  rocket_fam_response = RestClient.get(rocket_family_url)
  rocket_family = JSON.parse(rocket_fam_response)["RocketFamilies"][0]
  unless rocket_family.nil?
    # Retreive agency information from rocket_family
    @agency_data =  rocket_family["agencies"][0]["id"]
    @agency_url = agency_url+"/#{@agency_data}"
    @agency_response = RestClient.get(@agency_url)
    @agency = JSON.parse(@agency_response)["agencies"]
    end
      # Create all agencies
      unless @agency.nil?
        @name = @agency[0]["name"]
        @abbrev = @agency[0]["abbrev"]
        @countryCode = @agency[0]["countryCode"]
        Agency.create(name:@name,abbrev:@abbrev,countryCode:@countryCode,islsp:@islsp)
      end
end


  rocket_data['rockets'].each do |rocket|
    @rocket_name = rocket["name"]
    @rocket_info = rocket["infoURL"]
    @rocket_wiki = rocket["wikiURL"]
    @rocket_img = rocket["imageURL"]
    rocket_family_url = "https://launchlibrary.net/1.3/rocketfamily/#{@rocket_name.split(' ')[0]}"
    rocket_fam_response = RestClient.get(rocket_family_url)
    rocket_family = JSON.parse(rocket_fam_response)["RocketFamilies"][0]
    unless rocket_family.nil?
      @rocket_agency_name = rocket_family["agencies"][0]["name"]
    end
    a = Agency.all.find_by_name(@rocket_agency_name)
    a.rockets.build(name: @rocket_name, info:@rocket_info, wiki:@rocket_wiki, img:@rocket_img).save
    end




