json.array!(@shops) do |shop|
  json.extract! shop, :name, :book_id, :latitude, :longitude, :open_time, :close_time, :adress, :memo
  json.url shop_url(shop, format: :json)
end
