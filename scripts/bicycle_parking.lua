local bicycle_parking = osm2pgsql.define_node_table('bicycle_parking', {
    { column = 'tags', type = 'jsonb' },
    { column = 'geom', type = 'point' },
})

function osm2pgsql.process_node(object)
    if object.tags.amenity ~= 'bicycle_parking' then
        return
    end

    bicycle_parking:insert({
        tags = object.tags,
        geom = object:as_point()
    })
end
