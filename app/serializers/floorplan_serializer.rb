class FloorplanSerializer < ActiveModel::Serializer
  has_many :flats
  attributes :windows, :left_window, :middle_window, :right_window
end
