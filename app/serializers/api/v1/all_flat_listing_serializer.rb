module Api::V1
  class AllFlatListingSerializer < ActiveModel::Serializer
    attributes :bed, :bath, :stack, :floor, :sqft, :city_view, :listings

    def bed
      object.bed.to_i
    end

    def bath
      object.bath.to_i
    end

    def stack
      object.stack
    end

    def floor
      object.floor.to_i
    end

    def sqft
      object.sqft.to_i
    end

    def city_view
      object.city_view_before_type_cast
    end

    def listings
      listings_array = []
      object.listings.each do |l|
        listings_array.push({'price': l[:price], 'created-at': l[:created_at]})
      end
      return listings_array
    end

  end
end
