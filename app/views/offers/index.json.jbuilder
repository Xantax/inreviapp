json.array!(@offers) do |offer|
  json.extract! offer, :id, :name, :description, :image, :service, :price, :user_id
  json.url offer_url(offer, format: :json)
end
