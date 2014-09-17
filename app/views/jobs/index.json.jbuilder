json.array!(@jobs) do |job|
  json.extract! job, :id, :name, :description, :image, :location, :deleted, :user_id, :total_clicks, :remote
  json.url job_url(job, format: :json)
end
