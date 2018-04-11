module Api::V1
  class FlatSerializer < ActiveModel::Serializer
    attributes :identifier, :hirise, :floor, :stack, :bedroom, :bathroom, :square_feet, :is_active, :windows, :city_view, :floor_plan, :listings

    def identifier
      object.id
    end

    def hirise
      object.floorplan.hirise unless object.floorplan.nil?
    end

    def floor
      object.floor.to_i
    end

    def bedroom
      object.bed
    end

    def bathroom
      object.bath
    end

    def square_feet
      object.sqft
    end

    def windows
      object.floorplan.window_array unless object.floorplan.nil?
    end

    def city_view
      object.city_view
    end

    def floor_plan
      object.floorplan.layout_path unless object.floorplan.nil?
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
