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
      "#{alph(layout_id.modulo(26*26))}: #{layout_version}"
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
    if layout_version.blank? && hirise['nema']
      "https://www.rentnema.com/img/floorplans/plan/#{layout_id}.jpg"
    elsif hirise['nema']
      "https://s3-us-west-1.amazonaws.com/flats-nema/#{layout_id}-#{layout_version}.jpg"
    elsif hirise['jasper'] && !flats.empty?
      flats.first.layout_path
    else
      return ''
    end
  end

  enum hirise: [:nema, :jasper]
end
