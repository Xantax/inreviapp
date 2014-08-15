json.array!(@reviews) do |review|
  json.extract! review, :id, :positive, :body, :proof, :image, :offer_id, :buyer_id, :seller_id, :order_id
  json.url review_url(review, format: :json)
end
