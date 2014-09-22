json.array!(@promoted_rents) do |promoted_rent|
  json.extract! promoted_rent, :id, :name, :location, :tag_list, :price, :image, :quantity, :user_id, :rent_id, :clicks, :set_clicks, :sell, :unavailable, :temporal_id, :per_temporal_id
  json.url promoted_rent_url(promoted_rent, format: :json)
end
