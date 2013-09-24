# --------------------
# kikunantoka added
# --------------------

require "open-uri"
require "rubygems"
require "nokogiri"
require 'mechanize'
require 'kconv'

class Stock_renewal
	def self.test
		@books = Book.all
		puts "This is test"
		@books.each do |book|			
			
			url = "http://www.junkudo.co.jp/mj/products/list.php"
			agent = Mechanize.new
			page = agent.get(url)
			shop_name = ""
			
			agent.page.form_with(:id => 'mjSearchForm') {|f|
			  f['search_text'] = book.isbn.toutf8
			  f.click_button
			}
			agent.page.link_with(:text => "詳細".toutf8).click
			
			stock_url =  agent.page.uri
			stock_url = stock_url.to_s.sub("detail", "stock")
			
			page = agent.get(stock_url)
						
			agent.page.search('.table-mini td:first-child').each do |shop|
				shop_name = shop.text.strip
				if shop_name.include?(" ") 
					shop_name = shop_name.delete(" ")
				end
				if shop_name.include?("　") 
					shop_name = shop_name.delete("　")
				end
				puts shop_name
				
# 				shop = Shop.find_by name: shop_name
# 				if shop.present?
# 					puts shop.id
# 				end

			end
						
		end
		
# 		Shop.create(:name => "hogehoge",:latitude => 10.0,:longitude => 10.0,:address => "hogehoge")
	end
end








# --------------------
# finish
# --------------------