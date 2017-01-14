json.extract! flat, :id, :bed, :bath, :suite, :floor, :sqft, :is_active, :created_at, :updated_at
json.url flat_url(flat, format: :json)