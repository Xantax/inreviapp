json.array!(@alerts) do |alert|
  json.extract! alert, :id, :body, :user_id, :image
  json.url alert_url(alert, format: :json)
end
