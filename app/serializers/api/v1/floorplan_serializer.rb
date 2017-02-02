module Api::V1
  class FloorplanSerializer < ActiveModel::Serializer
    has_many :flats

    attributes :layout_id, :layout_path, :studio_windows
  end
end
