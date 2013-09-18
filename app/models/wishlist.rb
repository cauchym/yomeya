class Wishlist < ActiveRecord::Base

	attr_accessible :user_id, :book_id, :shop_id
	attr_accessor :book_title, :shop_name

	validates :url :presence => true
	validates :notice :presence => true


	has_and_belongs_to_many :books
	belongs_to :user
end