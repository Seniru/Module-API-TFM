return function(name, etype, id, value)
    local t = type(value)
    if type(etype) == "table" then
        local names, counter = {}, 0
        for k, v in next, etype do
            if v == t then
                return
            else
                counter = counter + 1
                names[counter] = v
            end
        end
        error("bad argument #" .. id .. " to '" .. name .. "' (" .. table.concat(names, " | ") .. " expected, got " .. t .. ")")    else        assert(t == etype, "bad argument #" .. id .. " to '" .. name .. "' (" .. etype .. " expected, got " .. t .. ")")
    end
end
 