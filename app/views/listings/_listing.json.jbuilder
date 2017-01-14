json.extract! listing, :id, :flat_id, :price, :fetch_date, :created_at, :updated_at
json.url listing_url(listing, format: :json)
