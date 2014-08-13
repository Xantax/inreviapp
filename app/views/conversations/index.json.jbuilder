json.array!(@conversations) do |conversation|
  json.extract! conversation, :id, :user_id, :offer_id, :recipient_id, :messages_count
  json.url conversation_url(conversation, format: :json)
end
