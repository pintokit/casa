class FloorplanSerializer < ActiveModel::Serializer
  has_many :flats
  
  attributes :id, :left_window, :middle_window, :right_window, :layout_id, :layout_path
end
