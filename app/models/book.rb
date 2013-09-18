class Book < ActiveRecord::Base

	attr_accessible :wishlist_id, :book_id, :shop_id
	attr_accessor :book_title, :shop_name

	has_and_belongs_to_many :shops
	has_and_belongs_to_many :wishlists

	validates :title :presence => true
	validates :author :presence => true
	validates :value :presence => true

end
