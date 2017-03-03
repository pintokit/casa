class Floorplan < ApplicationRecord
  has_many :flats
  serialize :windows
  store_accessor :windows, :window1, :window2, :window3, :window4, :window5
  validates :layout_id, numericality: { only_integer: true }

  default_scope { order(layout_id: :asc) }

  # convert layout_ids to a name
  def alph(x)
    array = ("AA".."ZZ").to_a
    return array[x]
  end

  def name
    if layout_id.nil?
      "No Layout"
    else
      "#{alph(layout_id.modulo(26*26))}: #{id}"
    end
  end

  def window_array
    unless windows.blank?
      array = windows.values
      array.delete_if(&:blank?)
      return array unless array.empty?
    end
  end

  def layout_path
    if layout_image.blank?
      "https://www.rentnema.com/img/floorplans/plan/#{layout_id}.jpg"
    else
      "https://s3-us-west-1.amazonaws.com/flats-nema/#{layout_image}.jpg"
    end
  end
end
