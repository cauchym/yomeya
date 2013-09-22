class Shop < ActiveRecord::Base

	attr_accessible :wishlist_id, :book_id, :shop_id, :name, :latitude, :longitude, :open_time, :close_time, :adress
	attr_accessor :book_title, :shop_name
	
	acts_as_mappable

	has_and_belongs_to_many :book

	validates :name, :presence => true
	validates :longitude, :presence => true
	validates :latitude, :presence => true
	
end
