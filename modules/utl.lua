local utl = {}

function utl.clone (t) -- deep-copy a table
    if type(t) ~= "table" then return t end
    local meta = getmetatable(t)
    local target = {}
    for k, v in pairs(t) do
        if type(v) == "table" then
            target[k] = utl.clone(v)
        else
            target[k] = v
        end
    end
    setmetatable(target, meta)
    return target
end

return utl