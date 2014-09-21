json.array!(@rents) do |rent|
  json.extract! rent, :id, :name, :description, :image, :location, :tag_list, :deleted, :user_id, :unavailable, :total_clicks, :quantity
  json.url rent_url(rent, format: :json)
end
