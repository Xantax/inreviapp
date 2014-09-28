json.array!(@endorsements) do |endorsement|
  json.extract! endorsement, :id, :body, :writer_id, :endorsed_id
  json.url endorsement_url(endorsement, format: :json)
end
