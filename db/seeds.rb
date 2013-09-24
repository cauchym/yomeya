# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# -*- coding: utf-8 -*-
require "open-uri"
require "rubygems"
require "nokogiri"
require 'mechanize'
require 'kconv'
require 'net/http'
require 'json'

# users_name = ['社長', 'なっくる', 'kikunantoka', 'こし']
# users = User.all
# if users.blank?
#   users_name.each do |name|
#     User.create(:name => name)
#   end
# end
# users = User.all

def geocode(address)
   address = URI.encode(address)
   hash = Hash.new
   baseUrl = "http://maps.google.com/maps/api/geocode/json"
   reqUrl = "#{baseUrl}?address=#{address}&sensor=false&language=ja"
   response = Net::HTTP.get_response(URI.parse(reqUrl))
   status = JSON.parse(response.body)
   if status['results'][0]['geometry']['location']['lat'].present?
		hash['lat'] = status['results'][0]['geometry']['location']['lat']
		hash['lng'] = status['results'][0]['geometry']['location']['lng']
		return hash
	 else
	 	hash['lat'] = 0
	 	hash['lng'] = 0
	 	return hash
	 end
	 
end

shops = Shop.all
if shops.blank?
	# -------------------------------
	# shoplistのスクレイピング
	# -------------------------------
	url = "http://www.junkudo.co.jp/mj/store/store_search.php"
	name_array = []
	address_array = []
	
	agent = Mechanize.new
	page = agent.get(url)
	
	agent.page.search('.table td > a').each do |link|
	
		agent.page.link_with(:text => link.text.toutf8).click
	
		shop_name = agent.page.at('.store_description h3').text.strip
		if shop_name.include?(" ") 
			shop_name = shop_name.delete(" ")
		end
		if shop_name.include?("　") 
			shop_name = shop_name.delete("　")
		end
		
	# 	puts name
		
		tel = agent.page.at('.store_description h4').text.strip
		if tel.include?("TEL.") 
			tel = tel.delete("TEL.")
		end
	# 	puts tel
		
		shop_address = agent.page.at('.store_description p').text.strip
		if shop_address.include?("地図を見る") 
			shop_address = shop_address.delete("地図を見る")
		end
	# 	puts address
		
# 		shop_geo = geocode(shop_address)
		
		open_time = agent.page.at('.store_description h5 span').text.strip
	# 	puts open_time
		
		closed_day = agent.page.at('.store_description h5 span:nth-child(5)').text.strip
	# 	puts closed_day
		
		page = agent.get(url)
		
	# 	puts("----------------------------------")
	
		Shop.create(:name => shop_name,:latitude => 0,:longitude => 0,:address => shop_address)	

# 		Shop.create(:name => shop_name,:latitude => shop_geo['lat'],:longitude => shop_geo['lng'],:address => shop_address)	
	

	end
	# -------------------------------
	# 終わり
	# -------------------------------
end
shops = Shop.all

# genres_name = ['不具合', '要望', '質問', 'その他']
# genres = Genre.all
# if genres.blank?
#   genres_name.each do |name|
#     Genre.create(:name => name)
#   end
# end
# 
# machines_name = ['SP', 'FP']
# machines = Machine.all
# if machines.blank?
#   machines_name.each do |name|
#     Machine.create(:name => name)
#   end
# end

# if Rails.env == 'development'
#   User.create(email: "staff@example.com", password: "password", password_confirmation: "password", name: "すたっふ", role: "admin")
#   puts %Q!
# 1 staff users have been created.
# You can now log in as 'staff@example.com' with passowrd 'password'
#   !
# end

