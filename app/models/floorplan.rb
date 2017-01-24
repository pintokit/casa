class Floorplan < ApplicationRecord
  has_many :flats
  serialize :windows, HashSerializer
  store_accessor :windows, :left_window, :middle_window, :right_window

  def studio_windows
    output = ""

    if windows.blank?
      output = "❔❔❔"
    end

    windows.each do |window, position|
      if position == "0"
        output.concat("⬜️")
      elsif position == "1"
        output.concat("🖼")
      end
    end

    return output
  end

  def layout_path
    "https://www.rentnema.com/img/floorplans/plan/#{layout_id}.jpg"
  end
end
