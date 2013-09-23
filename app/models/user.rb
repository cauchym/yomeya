class User < ActiveRecord::Base
	
	attr_accessible :wishlist_id, :email, :password
	attr_accessor :book_title, :shop_name

	has_many :wishlists

	validates :email, :presence => true, :uniqueness=>true
	validates :password, :presence => true
	validates :wishlist_id, :presence => true
	#validates :integer, :presence => true
end