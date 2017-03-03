module Api::V1
  class AllFloorplanSerializer < ActiveModel::Serializer
    attributes :layout, :version, :windows, :flats

    def layout
      object.layout_id
    end

    def version
      object.layout_version
    end

    def flats
      flats_array = []
      object.flats.each do |f|
        flats_array.push({'floor': f[:floor], 'stack': f[:stack]})
      end
      return flats_array
    end

  end
end
