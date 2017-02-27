module Api::V1
  class FlatSerializer < ActiveModel::Serializer
    attributes :identifier, :floor, :stack, :bed, :bath, :sqft, :is_active, :windows, :city_view, :layout_url, :price, :listing_updated_at

    def identifier
      object.id
    end

    def floor
      object.floor.to_i
    end

    def windows
      object.floorplan.window_array unless object.floorplan.nil?
    end

    def city_view
      [object.city_view_before_type_cast, object.city_view]
    end

    def layout_url
      object.floorplan.layout_path unless object.floorplan.nil?
    end

    def price
      object.listings.last.price
    end

    def listing_updated_at
      object.listings.last.created_at
    end
  end
end
