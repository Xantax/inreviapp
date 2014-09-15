json.array!(@services) do |service|
  json.extract! service, :id, :name, :description, :image, :location, :price, :deleted, :user_id, :total_clicks
  json.url service_url(service, format: :json)
end
