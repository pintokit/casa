module Api::V1
  class AllFloorplanSerializer < ActiveModel::Serializer
    attributes :layout, :windows, :flats

    def layout
      object.layout_id
    end

    def flats
      unless object.flats.empty?
        flats_array = []
        object.flats.each do |f|
          flats_array.push({'floor': f[:floor].to_i, 'stack': f[:stack].to_i})
        end
        return flats_array
      end
    end

  end
end
