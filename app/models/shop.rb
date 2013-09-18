class Shop < ActiveRecord::Base


	attr_accessible :wishlist_id, :book_id, :shop_id
	attr_accessor :book_title, :shop_name


	has_and_belongs_to_many :book


	validates :name :presence => true
	validates :longitude :presence => true
	validates :latitude :presence => true
end
