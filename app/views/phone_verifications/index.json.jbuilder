json.array!(@phone_verifications) do |phone_verification|
  json.extract! phone_verification, :id, :number, :user_id
  json.url phone_verification_url(phone_verification, format: :json)
end
