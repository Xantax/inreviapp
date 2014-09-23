json.array!(@works) do |work|
  json.extract! work, :id, :name, :description, :image, :location, :tag_list, :user_id, :deleted, :temporal_id, :per_temporal_id, :total_clicks, :quantity, :price
  json.url work_url(work, format: :json)
end