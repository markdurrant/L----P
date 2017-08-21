local path = {}

function path:new()
  local this = {}

  this.type = "path"
  this.closed = false
  this.points = {}

  function this:addPoint(...)
    for i, point in pairs({...}) do
      table.insert(this.points, point)
    end
  end

  function this:render()
    local pathTag = ""
    local pathContent = ""

    for k, point in pairs(this.points) do
      if k == 1 then
        pathContent = "M"
      else
        pathContent = pathContent .. " L"
      end

      pathContent = pathContent .. point.x .. " " .. point.y
    end

    if this.closed == true then
      pathContent = pathContent .. " Z"
    end

    pathTag = '<path d="' .. pathContent .. '"/>'

    return pathTag
  end

  return this
end

return path