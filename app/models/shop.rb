class Shop < ActiveRecord::Base


	attr_accessible :wishlist_id, :book_id, :shop_id, :name, :latitude, :longitude, :open_time, :close_time, :adress
	attr_accessor :book_title, :shop_name
	
	#geokit-railsの設定
	acts_as_mappable :default_units => :kms,
					 :lat_column_name => :latitude,
					 :lng_column_name => :longitude

	has_and_belongs_to_many :book

	validates :name, :presence => true
	validates :longitude, :presence => true
	validates :latitude, :presence => true
	
end
