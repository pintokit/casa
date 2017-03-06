class ApplicationJob < ActiveJob::Base
  def nema_flats(hirise, units_json, bed_type)
    Flat.joins(:floorplan).where(flats: {bed: bed_type}, floorplans: {hirise: hirise}).update_all is_active: false

    units_json.each do |unit|
      flat = Flat.find_or_create_by!(floor: unit['uf'], stack: unit['un'], sqft: unit['sq'], bath: unit['bathType'], bed: bed_type)
      floorplan = Floorplan.find_or_create_by!(layout_id: unit['fi'], hirise: hirise)
      current_price = unit['rent'].delete(',').to_i
      last_listing = flat.listings.last

      if flat.listings.empty? || last_listing.price != current_price
        Listing.create!(flat: flat, price: current_price)
      end

      flat.update! is_active: true
      unless flat.floorplan.present?
        flat.update! floorplan: floorplan
      end
    end
  end
end
