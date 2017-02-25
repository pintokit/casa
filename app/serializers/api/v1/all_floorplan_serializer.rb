module Api::V1
  class AllFloorplanSerializer < ActiveModel::Serializer
    attributes :layout, :windows, :flats

    def layout
      object.layout_id
    end
  end
end
