json.array!(@phone_codes) do |phone_code|
  json.extract! phone_code, :id, :code, :user_id
  json.url phone_code_url(phone_code, format: :json)
end
