module Api::V1
  class ListingSerializer < ActiveModel::Serializer
    attributes :price, :created_at

  end
end
