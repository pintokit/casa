module Api::V1
  class FlatSerializer < ActiveModel::Serializer
    attributes :identifier, :bed, :bath, :stack, :floor, :sqft, :is_active, :windows, :latest_price, :price_updated_at, :layout_path, :window_score

    def identifier
      object.id.to_i
    end

    def floor
      object.floor.to_i
    end

    def windows
      object.floorplan.window_array unless object.floorplan.nil?
    end

    def window_score
      object.floorplan.window_score unless object.floorplan.nil?
    end

    def latest_price
      object.listings.last.price
    end

    def price_updated_at
      object.listings.last.created_at
    end

    def layout_path
      object.floorplan.layout_path unless object.floorplan.nil?
    end
  end
end
