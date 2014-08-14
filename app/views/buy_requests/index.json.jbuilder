json.array!(@buy_requests) do |buy_request|
  json.extract! buy_request, :id, :user_id, :conversation_id, :offer_id
  json.url buy_request_url(buy_request, format: :json)
end
