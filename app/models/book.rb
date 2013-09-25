class Book < ActiveRecord::Base

	attr_accessible :wishlist_id, :book_id, :shop_id, :title, :author, :value, :isbn, :image
	attr_accessor :book_title, :shop_name

# 	has_and_belongs_to_many :shops
# 	has_and_belongs_to_many :wishlists

	validates :title, :presence => false
	validates :author, :presence => false
	validates :value, :presence => false
	
	def self.Stock_renewal(isbn,create_flag)
		shop_array = []
		book_array = []
		shop_name = ""
		isbn = isbn.to_s
	
		url = "http://www.junkudo.co.jp/mj/products/list.php"
		agent = Mechanize.new
		page = agent.get(url)
		
		agent.page.form_with(:id => 'mjSearchForm') {|f|
		  f['search_text'] = isbn.toutf8
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
			
			shop = Shop.find_by name: shop_name
			if shop.book_id.nil?
				shop.book_id = isbn.to_s
				shop.save
			else
				if shop.book_id.to_s.include?(isbn)
				else
					book_array = shop.book_id.split(",")
					book_array.push isbn
					book_str = book_array.join(",")
					shop.book_id = book_str
					shop.save
				end
			end
			shop_array.push shop.id
		end
		
		shop_str = shop_array.join(",")
		
		if create_flag == 1
			return shop_str
		else			
			@book = Book.find_by isbn: isbn
			@book.shop_id = shop_str
			@book.save
		end
	
	end

end
