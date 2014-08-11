json.array!(@promoted_offers) do |promoted_offer|
  json.extract! offer, :id, :offer_id,  :user_id
  json.url promoted_offer_url(promoted_offer, format: :json)
end