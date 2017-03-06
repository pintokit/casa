module Api::V1
  class FlatSerializer < ActiveModel::Serializer
    attributes :identifier, :hirise, :floor, :stack, :bed, :bath, :sqft, :is_active, :windows, :city_view, :floorplan_url, :price, :listing_updated_at

    def identifier
      object.id
    end

    def hirise
      object.floorplan.hirise unless object.floorplan.nil?
    end

    def floor
      object.floor.to_i
    end

    def windows
      object.floorplan.window_array unless object.floorplan.nil?
    end

    def city_view
      object.city_view
    end

    def floorplan_url
      object.layout_path unless object.floorplan.nil?
    end

    def price
      object.listings.last.price
    end

    def listing_updated_at
      object.listings.last.created_at
    end
  end
end
