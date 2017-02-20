class Floorplan < ApplicationRecord
  has_many :flats
  serialize :windows
  store_accessor :windows, :consecutive_windows, :total_windows

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

  def assigned_flats
    output = []
    flats.each do |flat|
      output.push(flat.name)
    end
    unless output.empty?
      return output
    end
  end

  def window_score
    output = nil

    unless windows.nil?
      windows.each_value do |window|
        output =+ window
      end
    end

    return output
  end

  def layout_path
    "https://www.rentnema.com/img/floorplans/plan/#{layout_id}.jpg"
  end
end
