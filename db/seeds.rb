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

mission_url = 'https://launchlibrary.net/1.3/mission'
mission_response = RestClient.get(mission_url)
mission_data = JSON.parse(mission_response)

pad_url = 'https://launchlibrary.net/1.3/pad'
pad_response = RestClient.get(pad_url)
pad_data = JSON.parse(pad_response)


# # Drop all tables
RocketPad.delete_all
Rocket.delete_all
Agency.delete_all
Mission.delete_all
Pad.delete_all
#################################################
#Pull all agencies from the rocket family dataset
################################################
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

##################################################
#Pull all agencies from the mission dataset
# ##################################################
mission_data['missions'].each do |m|
@mission_id = m["id"]
@url = "https://launchlibrary.net/1.3/mission/#{@mission_id}"
@response = RestClient.get(@url)
@data = JSON.parse(@response)["missions"]
  unless @data[0]["agencies"].nil?
    # Retreive agency information from missions
    @data[0]["agencies"].each do |mission_agency|
      @name = mission_agency["name"]
      @abbrev = mission_agency["abbrev"]
      @countryCode = mission_agency["countryCode"]
      Agency.create(name:@name,abbrev:@abbrev,countryCode:@countryCode)
  end
  end
end

###################################################
#Pull data into Mission table from missions dataset
# #################################################
mission_data['missions'].each do |mission|
  @name = mission["name"]
  @description = mission["description"]
  @wiki = mission["wikiURL"]
  # Find which agency this mission belongs to
    @mission_agency_url = "https://launchlibrary.net/1.3/mission/#{mission["id"]}"
    @mission_agency_response = RestClient.get(@mission_agency_url)
    @mission_agency = JSON.parse(@mission_agency_response)["missions"][0]
  unless @mission_agency["agencies"].nil?
    @mission_agency["agencies"].each do |mission_agency|
      a = Agency.find_by_abbrev(mission_agency["abbrev"])
      a.missions.build(name:@name,description:@description,wiki:@wiki).save
    end
  end
end

###################################################
#Pull all agencies into Agency table from pads dataset
# #################################################
pad_data["pads"].each do |pad|
  @pad_id = pad["id"]
  @url = "https://launchlibrary.net/1.3/pad/#{@pad_id}"
  @response = RestClient.get(@url)
  @data = JSON.parse(@response)["pads"]
  unless @data[0]["agencies"].nil?
    # Retreive agency information from missions
    @data[0]["agencies"].each do |pad_agency|
      @name = pad_agency["name"]
      @abbrev = pad_agency["abbrev"]
      @countryCode = pad_agency["countryCode"]
      Agency.create(name:@name,abbrev:@abbrev,countryCode:@countryCode)
    end
  end
end
##################################################
# Pull data on pads into Pad table form pads dataset
# ##################################################
rocket_data['rockets'].each do |rocket|
@url = "https://launchlibrary.net/1.3/rocket/#{rocket["id"]}"
@response = RestClient.get(@url)
@data = JSON.parse(@response)["rockets"][0]
  unless @data["defaultPads"].nil?
    @data["defaultPads"].split(',').each do |pad_data|
    $r = Rocket.create(name:@data["name"],wiki:@data["wikiURL"],img:@data["imgURL"],defaultPad:[pad_data])
      puts Rocket.count
    @pad_url = pad_url+"/#{pad_data}"
    @pad_response = RestClient.get(@pad_url)
    @pad_data = JSON.parse(@pad_response)["pads"]
      unless @pad_data.nil?
        @pad_data.each do |rocket_pad|
        @rocket_pad_url = pad_url+"/#{rocket_pad["id"]}"
        @rocket_pad_response = RestClient.get(@rocket_pad_url)
        @rocket_pad_data = JSON.parse(@rocket_pad_response)['pads']
          unless @rocket_pad_data.nil?
            @rocket_pad_data.each do |rocket_pad_data|
            $p = Pad.create(name:rocket_pad_data["name"],map:rocket_pad_data["mapURL"],pad_id:rocket_pad_data["id"])
          end
        end
     end
    end
  end
  end
  RocketPad.create(rocket: $r,pad: $p)
  puts RocketPad.count
end
#end

puts Mission.count