class Floorplan < ApplicationRecord
  has_many :flats
  store_accessor :windows, :left_window, :middle_window, :right_window

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

  def studio_windows
    output = ""

    if windows.nil?
      output = "❔❔❔"
    else
      windows.each do |window, position|
        if position == "0"
          output.concat("⬜️")
        elsif position == "1"
          output.concat("🖼")
        end
      end
    end

    return output
  end

  def layout_path
    "https://www.rentnema.com/img/floorplans/plan/#{layout_id}.jpg"
  end
end
