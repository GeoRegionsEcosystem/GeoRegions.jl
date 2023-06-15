function etopotype(type::String)
    if type == "bed"
        return "bed_elev"
    elseif type == "geoid"
        return "geoid"
    else
        return "surface_elev"
    end
end

function etoponamestring(type::String)
    if type == "bed"
        return "Bedrock"
    elseif type == "geoid"
        return "Geoid"
    else
        return "Surface"
    end
end