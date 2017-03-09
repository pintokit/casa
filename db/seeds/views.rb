# South Tower facing Mission St.
Flat.joins(:floorplan).where(flats: {floor: (16..23).to_a, stack: (26..32).to_a}, floorplans: {hirise: :nema}).update_all city_view: 'Unobstructed'

Flat.joins(:floorplan).where(flats: {floor: (11..15).to_a, stack: (26..28).to_a}, floorplans: {hirise: :nema}).update_all city_view: 'Partially Obstructed'

Flat.joins(:floorplan).where(flats: {floor: (11..15).to_a, stack: (29..32).to_a}, floorplans: {hirise: :nema}).update_all city_view: 'Mostly Obstructed'

Flat.joins(:floorplan).where(flats: {floor: (2..10).to_a, stack: (26..32).to_a}, floorplans: {hirise: :nema}).update_all city_view: 'Totally Obstructed'

# South Tower facing Market St.
Flat.joins(:floorplan).where(flats: {floor: (15..23).to_a, stack: 25}, floorplans: {hirise: :nema}).update_all city_view: 'Partially Obstructed' # 1br flat

Flat.joins(:floorplan).where(flats: {floor: (11..14).to_a, stack: 25}, floorplans: {hirise: :nema}).update_all city_view: 'Mostly Obstructed' # 1br flat

Flat.joins(:floorplan).where(flats: {floor: (15..23).to_a, stack: [23, 24]}, floorplans: {hirise: :nema}).update_all city_view: 'Mostly Obstructed' # Studios

Flat.joins(:floorplan).where(flats: {floor: (11..14).to_a, stack: [23, 24]}, floorplans: {hirise: :nema}).update_all city_view: 'Totally Obstructed' # Studios

Flat.joins(:floorplan).where(flats: {floor: (2..10).to_a, stack: [23, 24, 25]}, floorplans: {hirise: :nema}).update_all city_view: 'Totally Obstructed' # All flats

# South Midrise
Flat.joins(:floorplan).where(flats: {floor: (3..10).to_a, stack: (33..44).to_a}, floorplans: {hirise: :nema}).update_all city_view: 'Totally Obstructed'

# North Tower
Flat.joins(:floorplan).where(flats: {floor: (35..37).to_a, stack: [1, 3, 4, 5, 6, 7, 9, 11]}, floorplans: {hirise: :nema}).update_all city_view: 'Unobstructed' # 35+ clears the Uber tower

Flat.joins(:floorplan).where(flats: {floor: (26..34).to_a, stack: [5, 6]}, floorplans: {hirise: :nema}).update_all city_view: 'Unobstructed'
