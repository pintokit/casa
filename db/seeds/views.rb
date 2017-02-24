# South Tower facing Mission St.
Flat.where(floor: (16..23).to_a, stack: (26..32).to_a).update_all city_view: 'Unobstructed'

Flat.where(floor: (11..15).to_a, stack: (26..28).to_a).update_all city_view: 'Partially Obstructed'

Flat.where(floor: (11..15).to_a, stack: (29..32).to_a).update_all city_view: 'Mostly Obstructed'

Flat.where(floor: (2..10).to_a, stack: (26..32).to_a).update_all city_view: 'Totally Obstructed'

# South Tower facing Market St.
Flat.where(floor: (15..23).to_a, stack: 25).update_all city_view: 'Partially Obstructed' # 1br flat

Flat.where(floor: (11..14).to_a, stack: 25).update_all city_view: 'Mostly Obstructed' # 1br flat

Flat.where(floor: (15..23).to_a, stack: [23, 24]).update_all city_view: 'Mostly Obstructed' # Studios

Flat.where(floor: (11..14).to_a, stack: [23, 24]).update_all city_view: 'Totally Obstructed' # Studios

Flat.where(floor: (2..10).to_a, stack: [23, 24, 25]).update_all city_view: 'Totally Obstructed' # All flats

# South Midrise
Flat.where(floor: (3..10).to_a, stack: (33..44).to_a).update_all city_view: 'Totally Obstructed'

# North Tower

Flat.where(floor: (35..37).to_a, stack: [1, 3, 4, 5, 6, 7, 9, 11]).update_all city_view: 'Unobstructed' # 35+ clears the Uber tower

Flat.where(floor: (26..34).to_a, stack: [5, 6]).update_all city_view: 'Unobstructed'
